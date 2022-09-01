import wasmc

proc wasmVal*(val: int32 or uint32): wasmValT = wasmValT(kind: WasmI32, i32: cast[int32](val))
proc wasmVal*(val: int64 or uint64): wasmValT = wasmValT(kind: WasmI64, i64: cast[int64](val))
proc wasmVal*(val: float32): wasmValT = wasmValT(kind: WasmF32, f32: val)
proc wasmVal*(val: float64): wasmValT = wasmValT(kind: WasmF64, f64: val)


proc wasmArrayVec*(vals: openarray[wasmValT]): wasmValVecT =
  wasmValVecNew(addr result, csizet vals.len, vals[0].addr)
