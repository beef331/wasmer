import unittest
import wasmer/[wasmc, wasmerc]
import wasmer
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
    wat = newWasmByteVec(watString)
    wasmBytes: WasmByteVec
  wat2wasm(wat.addr, wasmBytes.addr)
  var
    engine = wasmEngineNew()
    store = wasmStoreNew(engine)
    module: ptr WasmModule

  test "Compile the Module":
    module = wasmModuleNew(store, addr wasmBytes)
    if module.isNil:
      echo getWasmerError()
    assert module != nil
    delete wasmBytes.addr

  var
    importObject: WasmExternVec
    instance: ptr WasmInstance

  test "Instantiate Module":
    instance = wasmInstanceNew(store, module, addr importObject, nil)
    if instance.isNil:
      echo getWasmerError()
    assert instance != nil

  var exports: WasmExternVec
  instance.exports(addr exports)

  if exports.size == 0:
    echo getWasmerError()
  assert exports.size > 0

  test "Retrive 'sum' func":
    var sumFunc = exports.data[0].asFunc
    if sumFunc == nil:
      echo getWasmerError()
    assert sumFunc != nil

    test "Call 'sum' func":
      var
        args = [wasmVal(3i32), wasmVal(4i32)]
        results: array[1, WasmVal]
      sumFunc.call(args, results)
      test "Ensure sum works":
        check results[0].i32 == 7



  delete(module)
  delete(addr exports)
  delete(instance)
  delete(store)
  delete(engine)




