import wasmer/wasmc

type
  WasmError* = object of CatchableError
  WasmCallError* = object of WasmError

proc newWasmByteVec*[T: char or byte](s: openarray[T]): WasmByteVec =
  wasmByteVecNew(result.addr, csizet s.len, cast[ptr byte](s[0].unsafeaddr))

proc wasmVal*(val: int32 or uint32): WasmVal = WasmVal(kind: WasmI32, i32: cast[int32](val))
proc wasmVal*(val: int64 or uint64): WasmVal = WasmVal(kind: WasmI64, i64: cast[int64](val))
proc wasmVal*(val: float32): WasmVal = WasmVal(kind: WasmF32, f32: val)
proc wasmVal*(val: float64): WasmVal = WasmVal(kind: WasmF64, f64: val)


proc wasmArrayVec*(vals: openarray[WasmVal]): WasmValVec =
  wasmValVecNew(addr result, csizet vals.len, vals[0].unsafeaddr)


proc call*(theFunc: ptr WasmFunc, args: openarray[WasmVal], results:  var openarray[WasmVal]) =
  var
    argVec = wasmArrayVec(args)
    resVec = wasmArrayVec(results)
  let theTrap = wasmFuncCall(theFunc, argVec.addr, resVec.addr)
  defer:
    delete addr argVec
    delete addr resVec
  if theTrap != nil:
    raise newException(WasmCallError, "Failed to call a procedure")

  for i in 0..<resVec.size:
    results[int i] = resVec.data[i]


