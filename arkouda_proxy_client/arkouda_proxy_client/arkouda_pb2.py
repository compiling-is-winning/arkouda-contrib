# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: arkouda.proto
"""Generated protocol buffer code."""
from google.protobuf.internal import builder as _builder
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\rarkouda.proto\x12\x07\x61rkouda\"\x8e\x01\n\x0e\x41rkoudaRequest\x12\x0c\n\x04user\x18\x01 \x01(\t\x12\r\n\x05token\x18\x02 \x01(\t\x12\x0b\n\x03\x63md\x18\x03 \x01(\t\x12\x0e\n\x06\x66ormat\x18\x04 \x01(\t\x12\x0c\n\x04size\x18\x05 \x01(\x05\x12\x0c\n\x04\x61rgs\x18\x06 \x01(\t\x12\x17\n\nrequest_id\x18\x07 \x01(\tH\x00\x88\x01\x01\x42\r\n\x0b_request_id\"J\n\x0f\x41rkoudaResponse\x12\x0f\n\x07message\x18\x01 \x01(\t\x12\x17\n\nrequest_id\x18\x02 \x01(\tH\x00\x88\x01\x01\x42\r\n\x0b_request_id2O\n\x07\x41rkouda\x12\x44\n\rHandleRequest\x12\x17.arkouda.ArkoudaRequest\x1a\x18.arkouda.ArkoudaResponse\"\x00\x62\x06proto3')

_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, globals())
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'arkouda_pb2', globals())
if _descriptor._USE_C_DESCRIPTORS == False:

  DESCRIPTOR._options = None
  _ARKOUDAREQUEST._serialized_start=27
  _ARKOUDAREQUEST._serialized_end=169
  _ARKOUDARESPONSE._serialized_start=171
  _ARKOUDARESPONSE._serialized_end=245
  _ARKOUDA._serialized_start=247
  _ARKOUDA._serialized_end=326
# @@protoc_insertion_point(module_scope)
