import wasmc

type
  wasi_version_t* {.size: sizeof(cint).} = enum
    INVALID_VERSION = -1, LATEST = 0, SNAPSHOT0 = 1, SNAPSHOT1 = 2
  wasmer_compiler_t* {.size: sizeof(cint).} = enum
    CRANELIFT = 0, LLVM = 1, SINGLEPASS = 2
  wasmer_engine_t* {.size: sizeof(cint).} = enum
    UNIVERSAL = 0, DYLIB = 1, STATICLIB = 2
  wasmer_parser_operator_t* {.size: sizeof(cint).} = enum
    Unreachable, Nop, Block, Loop, If, Else, Try, Catch, CatchAll, Delegate, Throw,
    Rethrow, Unwind, End, Br, BrIf, BrTable, Return, Call, CallIndirect, ReturnCall,
    ReturnCallIndirect, Drop, Select, TypedSelect, LocalGet, LocalSet, LocalTee,
    GlobalGet, GlobalSet, I32Load, I64Load, F32Load, F64Load, I32Load8S, I32Load8U,
    I32Load16S, I32Load16U, I64Load8S, I64Load8U, I64Load16S, I64Load16U, I64Load32S,
    I64Load32U, I32Store, I64Store, F32Store, F64Store, I32Store8, I32Store16,
    I64Store8, I64Store16, I64Store32, MemorySize, MemoryGrow, I32Const, I64Const,
    F32Const, F64Const, RefNull, RefIsNull, RefFunc, I32Eqz, I32Eq, I32Ne, I32LtS,
    I32LtU, I32GtS, I32GtU, I32LeS, I32LeU, I32GeS, I32GeU, I64Eqz, I64Eq, I64Ne, I64LtS,
    I64LtU, I64GtS, I64GtU, I64LeS, I64LeU, I64GeS, I64GeU, F32Eq, F32Ne, F32Lt, F32Gt,
    F32Le, F32Ge, F64Eq, F64Ne, F64Lt, F64Gt, F64Le, F64Ge, I32Clz, I32Ctz, I32Popcnt,
    I32Add, I32Sub, I32Mul, I32DivS, I32DivU, I32RemS, I32RemU, I32And, I32Or, I32Xor,
    I32Shl, I32ShrS, I32ShrU, I32Rotl, I32Rotr, I64Clz, I64Ctz, I64Popcnt, I64Add,
    I64Sub, I64Mul, I64DivS, I64DivU, I64RemS, I64RemU, I64And, I64Or, I64Xor, I64Shl,
    I64ShrS, I64ShrU, I64Rotl, I64Rotr, F32Abs, F32Neg, F32Ceil, F32Floor, F32Trunc,
    F32Nearest, F32Sqrt, F32Add, F32Sub, F32Mul, F32Div, F32Min, F32Max, F32Copysign,
    F64Abs, F64Neg, F64Ceil, F64Floor, F64Trunc, F64Nearest, F64Sqrt, F64Add, F64Sub,
    F64Mul, F64Div, F64Min, F64Max, F64Copysign, I32WrapI64, I32TruncF32S,
    I32TruncF32U, I32TruncF64S, I32TruncF64U, I64ExtendI32S, I64ExtendI32U,
    I64TruncF32S, I64TruncF32U, I64TruncF64S, I64TruncF64U, F32ConvertI32S,
    F32ConvertI32U, F32ConvertI64S, F32ConvertI64U, F32DemoteF64, F64ConvertI32S,
    F64ConvertI32U, F64ConvertI64S, F64ConvertI64U, F64PromoteF32,
    I32ReinterpretF32, I64ReinterpretF64, F32ReinterpretI32, F64ReinterpretI64,
    I32Extend8S, I32Extend16S, I64Extend8S, I64Extend16S, I64Extend32S,
    I32TruncSatF32S, I32TruncSatF32U, I32TruncSatF64S, I32TruncSatF64U,
    I64TruncSatF32S, I64TruncSatF32U, I64TruncSatF64S, I64TruncSatF64U, MemoryInit,
    DataDrop, MemoryCopy, MemoryFill, TableInit, ElemDrop, TableCopy, TableFill,
    TableGet, TableSet, TableGrow, TableSize, MemoryAtomicNotify, MemoryAtomicWait32,
    MemoryAtomicWait64, AtomicFence, I32AtomicLoad, I64AtomicLoad, I32AtomicLoad8U,
    I32AtomicLoad16U, I64AtomicLoad8U, I64AtomicLoad16U, I64AtomicLoad32U,
    I32AtomicStore, I64AtomicStore, I32AtomicStore8, I32AtomicStore16,
    I64AtomicStore8, I64AtomicStore16, I64AtomicStore32, I32AtomicRmwAdd,
    I64AtomicRmwAdd, I32AtomicRmw8AddU, I32AtomicRmw16AddU, I64AtomicRmw8AddU,
    I64AtomicRmw16AddU, I64AtomicRmw32AddU, I32AtomicRmwSub, I64AtomicRmwSub,
    I32AtomicRmw8SubU, I32AtomicRmw16SubU, I64AtomicRmw8SubU, I64AtomicRmw16SubU,
    I64AtomicRmw32SubU, I32AtomicRmwAnd, I64AtomicRmwAnd, I32AtomicRmw8AndU,
    I32AtomicRmw16AndU, I64AtomicRmw8AndU, I64AtomicRmw16AndU, I64AtomicRmw32AndU,
    I32AtomicRmwOr, I64AtomicRmwOr, I32AtomicRmw8OrU, I32AtomicRmw16OrU,
    I64AtomicRmw8OrU, I64AtomicRmw16OrU, I64AtomicRmw32OrU, I32AtomicRmwXor,
    I64AtomicRmwXor, I32AtomicRmw8XorU, I32AtomicRmw16XorU, I64AtomicRmw8XorU,
    I64AtomicRmw16XorU, I64AtomicRmw32XorU, I32AtomicRmwXchg, I64AtomicRmwXchg,
    I32AtomicRmw8XchgU, I32AtomicRmw16XchgU, I64AtomicRmw8XchgU,
    I64AtomicRmw16XchgU, I64AtomicRmw32XchgU, I32AtomicRmwCmpxchg,
    I64AtomicRmwCmpxchg, I32AtomicRmw8CmpxchgU, I32AtomicRmw16CmpxchgU,
    I64AtomicRmw8CmpxchgU, I64AtomicRmw16CmpxchgU, I64AtomicRmw32CmpxchgU,
    V128Load, V128Store, V128Const, I8x16Splat, I8x16ExtractLaneS, I8x16ExtractLaneU,
    I8x16ReplaceLane, I16x8Splat, I16x8ExtractLaneS, I16x8ExtractLaneU,
    I16x8ReplaceLane, I32x4Splat, I32x4ExtractLane, I32x4ReplaceLane, I64x2Splat,
    I64x2ExtractLane, I64x2ReplaceLane, F32x4Splat, F32x4ExtractLane,
    F32x4ReplaceLane, F64x2Splat, F64x2ExtractLane, F64x2ReplaceLane, I8x16Eq,
    I8x16Ne, I8x16LtS, I8x16LtU, I8x16GtS, I8x16GtU, I8x16LeS, I8x16LeU, I8x16GeS,
    I8x16GeU, I16x8Eq, I16x8Ne, I16x8LtS, I16x8LtU, I16x8GtS, I16x8GtU, I16x8LeS,
    I16x8LeU, I16x8GeS, I16x8GeU, I32x4Eq, I32x4Ne, I32x4LtS, I32x4LtU, I32x4GtS,
    I32x4GtU, I32x4LeS, I32x4LeU, I32x4GeS, I32x4GeU, I64x2Eq, I64x2Ne, I64x2LtS,
    I64x2GtS, I64x2LeS, I64x2GeS, F32x4Eq, F32x4Ne, F32x4Lt, F32x4Gt, F32x4Le, F32x4Ge,
    F64x2Eq, F64x2Ne, F64x2Lt, F64x2Gt, F64x2Le, F64x2Ge, V128Not, V128And, V128AndNot,
    V128Or, V128Xor, V128Bitselect, V128AnyTrue, I8x16Abs, I8x16Neg, I8x16AllTrue,
    I8x16Bitmask, I8x16Shl, I8x16ShrS, I8x16ShrU, I8x16Add, I8x16AddSatS,
    I8x16AddSatU, I8x16Sub, I8x16SubSatS, I8x16SubSatU, I8x16MinS, I8x16MinU,
    I8x16MaxS, I8x16MaxU, I8x16Popcnt, I16x8Abs, I16x8Neg, I16x8AllTrue, I16x8Bitmask,
    I16x8Shl, I16x8ShrS, I16x8ShrU, I16x8Add, I16x8AddSatS, I16x8AddSatU, I16x8Sub,
    I16x8SubSatS, I16x8SubSatU, I16x8Mul, I16x8MinS, I16x8MinU, I16x8MaxS, I16x8MaxU,
    I16x8ExtAddPairwiseI8x16S, I16x8ExtAddPairwiseI8x16U, I32x4Abs, I32x4Neg,
    I32x4AllTrue, I32x4Bitmask, I32x4Shl, I32x4ShrS, I32x4ShrU, I32x4Add, I32x4Sub,
    I32x4Mul, I32x4MinS, I32x4MinU, I32x4MaxS, I32x4MaxU, I32x4DotI16x8S,
    I32x4ExtAddPairwiseI16x8S, I32x4ExtAddPairwiseI16x8U, I64x2Abs, I64x2Neg,
    I64x2AllTrue, I64x2Bitmask, I64x2Shl, I64x2ShrS, I64x2ShrU, I64x2Add, I64x2Sub,
    I64x2Mul, F32x4Ceil, F32x4Floor, F32x4Trunc, F32x4Nearest, F64x2Ceil, F64x2Floor,
    F64x2Trunc, F64x2Nearest, F32x4Abs, F32x4Neg, F32x4Sqrt, F32x4Add, F32x4Sub,
    F32x4Mul, F32x4Div, F32x4Min, F32x4Max, F32x4PMin, F32x4PMax, F64x2Abs, F64x2Neg,
    F64x2Sqrt, F64x2Add, F64x2Sub, F64x2Mul, F64x2Div, F64x2Min, F64x2Max, F64x2PMin,
    F64x2PMax, I32x4TruncSatF32x4S, I32x4TruncSatF32x4U, F32x4ConvertI32x4S,
    F32x4ConvertI32x4U, I8x16Swizzle, I8x16Shuffle, V128Load8Splat, V128Load16Splat,
    V128Load32Splat, V128Load32Zero, V128Load64Splat, V128Load64Zero,
    I8x16NarrowI16x8S, I8x16NarrowI16x8U, I16x8NarrowI32x4S, I16x8NarrowI32x4U,
    I16x8ExtendLowI8x16S, I16x8ExtendHighI8x16S, I16x8ExtendLowI8x16U,
    I16x8ExtendHighI8x16U, I32x4ExtendLowI16x8S, I32x4ExtendHighI16x8S,
    I32x4ExtendLowI16x8U, I32x4ExtendHighI16x8U, I64x2ExtendLowI32x4S,
    I64x2ExtendHighI32x4S, I64x2ExtendLowI32x4U, I64x2ExtendHighI32x4U,
    I16x8ExtMulLowI8x16S, I16x8ExtMulHighI8x16S, I16x8ExtMulLowI8x16U,
    I16x8ExtMulHighI8x16U, I32x4ExtMulLowI16x8S, I32x4ExtMulHighI16x8S,
    I32x4ExtMulLowI16x8U, I32x4ExtMulHighI16x8U, I64x2ExtMulLowI32x4S,
    I64x2ExtMulHighI32x4S, I64x2ExtMulLowI32x4U, I64x2ExtMulHighI32x4U,
    V128Load8x8S, V128Load8x8U, V128Load16x4S, V128Load16x4U, V128Load32x2S,
    V128Load32x2U, V128Load8Lane, V128Load16Lane, V128Load32Lane, V128Load64Lane,
    V128Store8Lane, V128Store16Lane, V128Store32Lane, V128Store64Lane,
    I8x16RoundingAverageU, I16x8RoundingAverageU, I16x8Q15MulrSatS,
    F32x4DemoteF64x2Zero, F64x2PromoteLowF32x4, F64x2ConvertLowI32x4S,
    F64x2ConvertLowI32x4U, I32x4TruncSatF64x2SZero, I32x4TruncSatF64x2UZero,
    I8x16RelaxedSwizzle, I32x4RelaxedTruncSatF32x4S, I32x4RelaxedTruncSatF32x4U,
    I32x4RelaxedTruncSatF64x2SZero, I32x4RelaxedTruncSatF64x2UZero, F32x4Fma,
    F32x4Fms, F64x2Fma, F64x2Fms, I8x16LaneSelect, I16x8LaneSelect, I32x4LaneSelect,
    I64x2LaneSelect, F32x4RelaxedMin, F32x4RelaxedMax, F64x2RelaxedMin,
    F64x2RelaxedMax
  wasmer_named_extern_vec_t* {.bycopy.} = object
    size*: uint
    data*: ptr ptr wasmer_named_extern_t

  wasmer_metering_cost_function_t* = proc (wasm_operator: wasmer_parser_operator_t): uint64 {.
      cdecl.}
  wasmer_named_extern_t* {.bycopy.} = object
  wasmer_middleware_t* {.bycopy.} = object
  wasmer_features_t* {.bycopy.} = object
  wasmer_target_t* {.bycopy.} = object
  wasmer_cpu_features_t* {.bycopy.} = object
  wasmer_metering_t* {.bycopy.} = object
  wasmer_triple_t* {.bycopy.} = object


  wasi_config_t* {.bycopy.} = object
  wasi_env_t* {.bycopy.} = object






proc wasi_config_arg*(config: ptr wasi_config_t; arg: cstring) {.cdecl,
    importc: "wasi_config_arg", dynlib: wasmer.}
proc wasi_config_capture_stderr*(config: ptr wasi_config_t) {.cdecl,
    importc: "wasi_config_capture_stderr", dynlib: wasmer.}
proc wasi_config_capture_stdout*(config: ptr wasi_config_t) {.cdecl,
    importc: "wasi_config_capture_stdout", dynlib: wasmer.}
proc wasi_config_env*(config: ptr wasi_config_t; key: cstring; value: cstring) {.cdecl,
    importc: "wasi_config_env", dynlib: wasmer.}
proc wasi_config_inherit_stderr*(config: ptr wasi_config_t) {.cdecl,
    importc: "wasi_config_inherit_stderr", dynlib: wasmer.}
proc wasi_config_inherit_stdin*(config: ptr wasi_config_t) {.cdecl,
    importc: "wasi_config_inherit_stdin", dynlib: wasmer.}
proc wasi_config_inherit_stdout*(config: ptr wasi_config_t) {.cdecl,
    importc: "wasi_config_inherit_stdout", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasi_config_mapdir ( struct wasi_config_t * config , const char * alias , const char * dir ) ;
## Error: expected ';'!!!

proc wasi_config_new*(program_name: cstring): ptr wasi_config_t {.cdecl,
    importc: "wasi_config_new", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasi_config_preopen_dir ( struct wasi_config_t * config , const char * dir ) ;
## Error: expected ';'!!!

proc wasi_env_delete*(state: ptr wasi_env_t) {.cdecl, importc: "wasi_env_delete",
    dynlib: wasmer.}
proc wasi_env_new*(config: ptr wasi_config_t): ptr wasi_env_t {.cdecl,
    importc: "wasi_env_new", dynlib: wasmer.}
proc wasi_env_read_stderr*(env: ptr wasi_env_t; buffer: cstring; buffer_len: uint): int {.
    cdecl, importc: "wasi_env_read_stderr", dynlib: wasmer.}
proc wasi_env_read_stdout*(env: ptr wasi_env_t; buffer: cstring; buffer_len: uint): int {.
    cdecl, importc: "wasi_env_read_stdout", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasi_get_imports ( const wasm_store_t * store , const WasmModule * module , const struct wasi_env_t * wasi_env , wasm_extern_vec_t * imports ) ;
## Error: expected ';'!!!

proc wasi_get_start_function*(instance: ptr WasmInstance): ptr WasmFunc {.cdecl,
    importc: "wasi_get_start_function", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasi_get_unordered_imports ( const wasm_store_t * store , const WasmModule * module , const struct wasi_env_t * wasi_env , struct wasmer_named_extern_vec_t * imports ) ;
## Error: expected ';'!!!

proc wasi_get_wasi_version*(module: ptr WasmModule): wasi_version_t {.cdecl,
    importc: "wasi_get_wasi_version", dynlib: wasmer.}
## !!!Ignored construct:  void wasm_config_canonicalize_nans ( WasmConfig * config , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: token expected: ; but got: (!!!

proc wasm_config_push_middleware*(config: ptr WasmConfig;
                                 middleware: ptr wasmer_middleware_t) {.cdecl,
    importc: "wasm_config_push_middleware", dynlib: wasmer.}
proc wasm_config_set_compiler*(config: ptr WasmConfig;
                              compiler: wasmer_compiler_t) {.cdecl,
    importc: "wasm_config_set_compiler", dynlib: wasmer.}
proc wasm_config_set_engine*(config: ptr WasmConfig; engine: wasmer_engine_t) {.
    cdecl, importc: "wasm_config_set_engine", dynlib: wasmer.}
proc wasm_config_set_features*(config: ptr WasmConfig;
                              features: ptr wasmer_features_t) {.cdecl,
    importc: "wasm_config_set_features", dynlib: wasmer.}
proc wasm_config_set_target*(config: ptr WasmConfig; target: ptr wasmer_target_t) {.
    cdecl, importc: "wasm_config_set_target", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_cpu_features_add ( struct wasmer_cpu_features_t * cpu_features , const WasmName * feature ) ;
## Error: expected ';'!!!

proc wasmer_cpu_features_delete*(cpu_features: ptr wasmer_cpu_features_t) {.cdecl,
    importc: "wasmer_cpu_features_delete", dynlib: wasmer.}
proc wasmer_cpu_features_new*(): ptr wasmer_cpu_features_t {.cdecl,
    importc: "wasmer_cpu_features_new", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_bulk_memory ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

proc wasmer_features_delete*(features: ptr wasmer_features_t) {.cdecl,
    importc: "wasmer_features_delete", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_memory64 ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_module_linking ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_multi_memory ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_multi_value ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

proc wasmer_features_new*(): ptr wasmer_features_t {.cdecl,
    importc: "wasmer_features_new", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_reference_types ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_simd ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_tail_call ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_features_threads ( struct wasmer_features_t * features , # ./wasmert.h 3 4 [NewLine] _Bool # ./wasmert.h [NewLine] enable ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_is_compiler_available ( enum wasmer_compiler_t compiler ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_is_engine_available ( enum wasmer_engine_t engine ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_is_headless ( void ) ;
## Error: expected ';'!!!

proc wasmer_last_error_length*(): cint {.cdecl, importc: "wasmer_last_error_length",
                                      dynlib: wasmer.}
proc wasmer_last_error_message*(buffer: cstring; length: cint): cint {.cdecl,
    importc: "wasmer_last_error_message", dynlib: wasmer.}
proc wasmer_metering_as_middleware*(metering: ptr wasmer_metering_t): ptr wasmer_middleware_t {.
    cdecl, importc: "wasmer_metering_as_middleware", dynlib: wasmer.}
proc wasmer_metering_delete*(metering: ptr wasmer_metering_t) {.cdecl,
    importc: "wasmer_metering_delete", dynlib: wasmer.}
proc wasmer_metering_get_remaining_points*(instance: ptr WasmInstance): uint64 {.
    cdecl, importc: "wasmer_metering_get_remaining_points", dynlib: wasmer.}
proc wasmer_metering_new*(initial_limit: uint64;
                         cost_function: wasmer_metering_cost_function_t): ptr wasmer_metering_t {.
    cdecl, importc: "wasmer_metering_new", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_metering_points_are_exhausted ( const WasmInstance * instance ) ;
## Error: expected ';'!!!

proc wasmer_metering_set_remaining_points*(instance: ptr WasmInstance;
    new_limit: uint64) {.cdecl, importc: "wasmer_metering_set_remaining_points",
                         dynlib: wasmer.}
proc wasmer_module_name*(module: ptr WasmModule; `out`: ptr WasmName) {.cdecl,
    importc: "wasmer_module_name", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasmert.h [NewLine] wasmer_module_set_name ( WasmModule * module , const WasmName * name ) ;
## Error: expected ';'!!!

proc wasmer_named_extern_module*(named_extern: ptr wasmer_named_extern_t): ptr WasmName {.
    cdecl, importc: "wasmer_named_extern_module", dynlib: wasmer.}
proc wasmer_named_extern_name*(named_extern: ptr wasmer_named_extern_t): ptr WasmName {.
    cdecl, importc: "wasmer_named_extern_name", dynlib: wasmer.}
proc wasmer_named_extern_unwrap*(named_extern: ptr wasmer_named_extern_t): ptr WasmExtern {.
    cdecl, importc: "wasmer_named_extern_unwrap", dynlib: wasmer.}
proc wasmer_named_extern_vec_copy*(out_ptr: ptr wasmer_named_extern_vec_t;
                                  in_ptr: ptr wasmer_named_extern_vec_t) {.cdecl,
    importc: "wasmer_named_extern_vec_copy", dynlib: wasmer.}
proc wasmer_named_extern_vec_delete*(`ptr`: ptr wasmer_named_extern_vec_t) {.cdecl,
    importc: "wasmer_named_extern_vec_delete", dynlib: wasmer.}
proc wasmer_named_extern_vec_new*(`out`: ptr wasmer_named_extern_vec_t;
                                 length: uint;
                                 init: ptr ptr wasmer_named_extern_t) {.cdecl,
    importc: "wasmer_named_extern_vec_new", dynlib: wasmer.}
proc wasmer_named_extern_vec_new_empty*(`out`: ptr wasmer_named_extern_vec_t) {.
    cdecl, importc: "wasmer_named_extern_vec_new_empty", dynlib: wasmer.}
proc wasmer_named_extern_vec_new_uninitialized*(
    `out`: ptr wasmer_named_extern_vec_t; length: uint) {.cdecl,
    importc: "wasmer_named_extern_vec_new_uninitialized", dynlib: wasmer.}
proc wasmer_target_delete*(target: ptr wasmer_target_t) {.cdecl,
    importc: "wasmer_target_delete", dynlib: wasmer.}
proc wasmer_target_new*(triple: ptr wasmer_triple_t;
                       cpu_features: ptr wasmer_cpu_features_t): ptr wasmer_target_t {.
    cdecl, importc: "wasmer_target_new", dynlib: wasmer.}
proc wasmer_triple_delete*(triple: ptr wasmer_triple_t) {.cdecl,
    importc: "wasmer_triple_delete", dynlib: wasmer.}
proc wasmer_triple_new*(triple: ptr WasmName): ptr wasmer_triple_t {.cdecl,
    importc: "wasmer_triple_new", dynlib: wasmer.}
proc wasmer_triple_new_from_host*(): ptr wasmer_triple_t {.cdecl,
    importc: "wasmer_triple_new_from_host", dynlib: wasmer.}
proc wasmer_version*(): cstring {.cdecl, importc: "wasmer_version", dynlib: wasmer.}
proc wasmer_version_major*(): uint8 {.cdecl, importc: "wasmer_version_major",
                                     dynlib: wasmer.}
proc wasmer_version_minor*(): uint8 {.cdecl, importc: "wasmer_version_minor",
                                     dynlib: wasmer.}
proc wasmer_version_patch*(): uint8 {.cdecl, importc: "wasmer_version_patch",
                                     dynlib: wasmer.}
proc wasmer_version_pre*(): cstring {.cdecl, importc: "wasmer_version_pre",
                                   dynlib: wasmer.}
proc wat2wasm*(wat: ptr WasmByteVec; `out`: ptr WasmByteVec) {.cdecl,
    importc: "wat2wasm", dynlib: wasmer.}


proc getWasmerError*(): string =
  let len = wasmer_last_error_length()
  if len > 0:
    result = newString(len)
    discard wasmer_last_error_message(result.cstring, len)
