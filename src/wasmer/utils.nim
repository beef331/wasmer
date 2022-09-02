import wasmc

proc wasmVal*(val: int32 or uint32): WasmVal = WasmVal(kind: WasmI32, i32: cast[int32](val))
proc wasmVal*(val: int64 or uint64): WasmVal = WasmVal(kind: WasmI64, i64: cast[int64](val))
proc wasmVal*(val: float32): WasmVal = WasmVal(kind: WasmF32, f32: val)
proc wasmVal*(val: float64): WasmVal = WasmVal(kind: WasmF64, f64: val)


proc wasmArrayVec*(vals: openarray[WasmVal]): wasmValVecT =
  wasmValVecNew(addr result, csizet vals.len, vals[0].addr)
