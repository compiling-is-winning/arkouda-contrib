module lshMinMaxMsg
{

  use lshMinMax;
  use ServerConfig;
  use MultiTypeSymEntry;
  use ServerErrorStrings;
  use MultiTypeSymbolTable;
  use Message;
  use Reflection;
  use ServerErrors;
  use Logging;


  private config const logLevel = ServerConfig.logLevel;
  const cwsLogger = new Logger(logLevel);


  /* An implementation of a locality-sensitive hashing scheme for the MinMax (i.e. weighted 
     Jaccard) kernel originally described in "Consistent Weighted Sampling" (Manasse, McSherry
     Talwar). The specific implementation is an equivalent version by Sergie Ioffe described 
     in "Improved Consistent Sampling, Weighted Minhash, and L1 Sketching" that improves the
     runtime of the hashing setp from expected constant time to constant time. */


  proc lshMinMaxMsg(cmd: string, payload: string, st: borrowed SymTab): MsgTuple throws {

      param pn = Reflection.getRoutineName();

      var (offsets, elts, weights, zbit, hashes) = payload.splitMsgToTuple(5);

      const zBit: bool = zbit.toLower() == "true";
      var numHashes = try! hashes: int(64);
//      var offsetEnt: borrowed GenSymEntry = st.lookup(offsets);
//      var eltEnt: borrowed GenSymEntry = st.lookup(elts);
//      var weightEnt: borrowed GenSymEntry = st.lookup(weights);
      var offsetEnt: borrowed GenSymEntry = getGenericTypedArrayEntry(offsets, st);
      var eltEnt: borrowed GenSymEntry = getGenericTypedArrayEntry(elts, st);
      var weightEnt: borrowed GenSymEntry = getGenericTypedArrayEntry(weights, st);
      var repMsg:string;


      select(offsetEnt.dtype, eltEnt.dtype, weightEnt.dtype) {

          when(DType.Int64, DType.Int64, DType.Float64) {

              var setOffsets = toSymEntry(offsetEnt,int(64)); 
              var setElts =  toSymEntry(eltEnt,int(64));
              var eltWeights = toSymEntry(weightEnt,real(64));

              var (preimages, hashes) = getMinHashes(setOffsets.a, setElts.a, eltWeights.a, numHashes);

              var pmgName = st.nextName();
              var pmgEntry = new shared SymEntry(preimages);
              st.addEntry(pmgName, pmgEntry);
              repMsg =  "created " + st.attrib(pmgName);

              if(zBit) {
                  var hashName = st.nextName();
                  var hashEntry = new shared SymEntry(hashes);
                  st.addEntry(hashName, hashEntry);
                  repMsg += "+created " + st.attrib(hashName);
              }

              cwsLogger.error(getModuleName(),getRoutineName(),getLineNumber(),repMsg);
              return new MsgTuple(repMsg, MsgType.NORMAL);
          }
          otherwise {

              var errorMsg = notImplementedError("lshMinMax", offsetEnt.dtype);
              cwsLogger.error(getModuleName(),getRoutineName(),getLineNumber(),errorMsg);
              return new MsgTuple(errorMsg, MsgType.ERROR);
          }
      }
  }

  use CommandMap;
  registerFunction("lshMinMax", lshMinMaxMsg, getModuleName());
}
