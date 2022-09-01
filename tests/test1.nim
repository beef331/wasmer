import unittest
import wasmer/[wasmc, wasmerc, utils]
suite "Basic wasm test":
  const watString = """
    (module
      (type $sum_t (func (param i32 i32) (result i32)))
        (func $sum_f (type $sum_t) (param $x i32) (param $y i32) (result i32)
          local.get $x
          local.get $y
          i32.add)
      (export "sum" (func $sum_f)))
    """

  var
    wat, wasmBytes: wasmByteVecT

  wat.addr.wasmByteVecNew(csize_t high(watString), cast[ptr byte](watstring.cstring))
  wat2wasm(wat.addr, wasmBytes.addr)
  var
    engine = wasmEngineNew()
    store = wasmStoreNew(engine)
    module: ptr wasmModuleT

  test "Compile the Module":
    module = wasmModuleNew(store, addr wasmBytes)
    if module.isNil:
      echo getWasmerError()
    assert module != nil
    wasmByteVecDelete wasmBytes.addr

  var
    importObject: wasmExternVecT
    instance: ptr wasmInstanceT

  test "Instantiate Module":
    instance = wasmInstanceNew(store, module, addr importObject, nil)
    if instance.isNil:
      echo getWasmerError()
    assert instance != nil

  var exports: wasmExternVecT
  wasmInstanceExports(instance, addr exports)

  if exports.size == 0:
    echo getWasmerError()
  assert exports.size > 0

  test "Retrive 'sum' func":
    var sumFunc = wasmExternAsFunc(exports.data[0])
    if sumFunc == nil:
      echo getWasmerError()
    assert sumFunc != nil

    test "Call 'sum' func":
      var
        argVals = [wasmVal(3i32), wasmVal(4i32)]
        resultVals: array[1, wasmValT]
        args = wasmArrayVec(argVals)
        results = wasmArrayVec(resultVals)
      let call = wasmFuncCall(sumFunc, args.addr, results.addr)
      if call != nil:
        echo getWasmerError()
      assert call.isNil
      test "Ensure sum works":
        check results.data[0].i32 == 7



  wasmModuleDelete(module)
  wasmexternVecDelete(addr exports)
  wasmInstanceDelete(instance)
  wasmStoreDelete(store)
  wasmEngineDelete(engine)




