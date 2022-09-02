when defined(windows):
  const
    wasmer* = "wasmer.dll"
elif defined(macosx):
  const
    wasmer* = "libwasmer.dylib"
else:
  const
    wasmer* = "libwasmer.so"

type
  wasm_byte_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[byte]

template defineWasmType(name: untyped) =
  type name* {.bycopy.} = object

defineWasmType WasmConfig
defineWasmType WasmEngine
defineWasmType WasmStore
defineWasmType WasmValType
defineWasmType WasmFuncType
defineWasmType WasmGlobalType
defineWasmType WasmTableType
defineWasmType WasmMemoryType
defineWasmType WasmExternType
defineWasmType WasmImportType
defineWasmType WasmExportType
defineWasmType WasmRef
defineWasmType WasmFrame
defineWasmType WasmTrap
defineWasmType WasmForeign
defineWasmType WasmModule
defineWasmType WasmSharedModule
defineWasmType WasmInstance
defineWasmType WasmFunc
defineWasmType WasmGlobal
defineWasmType WasmTable
defineWasmType WasmMemory
defineWasmType WasmExtern
defineWasmType WasmImport
defineWasmType WasmExport


proc wasm_byte_vec_new_empty*(`out`: ptr wasm_byte_vec_t) {.cdecl,
    importc: "wasm_byte_vec_new_empty", dynlib: wasmer.}
proc wasm_byte_vec_new_uninitialized*(`out`: ptr wasm_byte_vec_t; a2: csize_t) {.
    cdecl, importc: "wasm_byte_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_byte_vec_new*(`out`: ptr wasm_byte_vec_t; a2: csize_t; a3: ptr byte) {.
    cdecl, importc: "wasm_byte_vec_new", dynlib: wasmer.}
proc wasm_byte_vec_copy*(`out`: ptr wasm_byte_vec_t; a2: ptr wasm_byte_vec_t) {.cdecl,
    importc: "wasm_byte_vec_copy", dynlib: wasmer.}
proc wasm_byte_vec_delete*(a1: ptr wasm_byte_vec_t) {.cdecl,
    importc: "wasm_byte_vec_delete", dynlib: wasmer.}
type
  wasm_name_t* = wasm_byte_vec_t

proc wasm_name_new_from_string*(`out`: ptr wasm_name_t; s: cstring) {.inline, cdecl.} =
  wasm_byte_vec_new(`out`, csize_t len(s), cast[ptr byte](s))

proc wasm_name_new_from_string_nt*(`out`: ptr wasm_name_t; s: cstring) {.inline, cdecl.} =
  wasm_byte_vec_new(`out`, csize_t len(s) + 1, cast[ptr byte](s))


proc wasm_config_delete*(a1: ptr WasmConfig) {.cdecl,
    importc: "wasm_config_delete", dynlib: wasmer.}
proc wasm_config_new*(): ptr WasmConfig {.cdecl, importc: "wasm_config_new",
    dynlib: wasmer.}

proc wasm_engine_delete*(a1: ptr WasmEngine) {.cdecl,
    importc: "wasm_engine_delete", dynlib: wasmer.}
proc wasm_engine_new*(): ptr WasmEngine {.cdecl, importc: "wasm_engine_new",
    dynlib: wasmer.}
proc wasm_engine_new_with_config*(a1: ptr WasmConfig): ptr WasmEngine {.cdecl,
    importc: "wasm_engine_new_with_config", dynlib: wasmer.}

proc wasm_store_delete*(a1: ptr WasmStore) {.cdecl, importc: "wasm_store_delete",
    dynlib: wasmer.}
proc wasm_store_new*(a1: ptr WasmEngine): ptr WasmStore {.cdecl,
    importc: "wasm_store_new", dynlib: wasmer.}
type
  Mutabillity* {.size: sizeof(uint8).} = enum
    WASM_CONST, WASM_VAR


type
  wasm_limits_t* {.bycopy.} = object
    min*: uint32
    max*: uint32


#var wasm_limits_max_default* {.importc: "wasm_limits_max_default", dynlib: wasmer.}: uint32


proc wasm_valtype_delete*(a1: ptr WasmValType) {.cdecl,
    importc: "wasm_valtype_delete", dynlib: wasmer.}
type
  wasm_valtype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmValType]


proc wasm_valtype_vec_new_empty*(`out`: ptr wasm_valtype_vec_t) {.cdecl,
    importc: "wasm_valtype_vec_new_empty", dynlib: wasmer.}
proc wasm_valtype_vec_new_uninitialized*(`out`: ptr wasm_valtype_vec_t; a2: csize_t) {.
    cdecl, importc: "wasm_valtype_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_valtype_vec_new*(`out`: ptr wasm_valtype_vec_t; a2: csize_t;
                          a3: ptr ptr WasmValType) {.cdecl,
    importc: "wasm_valtype_vec_new", dynlib: wasmer.}
proc wasm_valtype_vec_copy*(`out`: ptr wasm_valtype_vec_t;
                           a2: ptr wasm_valtype_vec_t) {.cdecl,
    importc: "wasm_valtype_vec_copy", dynlib: wasmer.}
proc wasm_valtype_vec_delete*(a1: ptr wasm_valtype_vec_t) {.cdecl,
    importc: "wasm_valtype_vec_delete", dynlib: wasmer.}
proc wasm_valtype_copy*(a1: ptr WasmValType): ptr WasmValType {.cdecl,
    importc: "wasm_valtype_copy", dynlib: wasmer.}
type
  ValKind* {.size: sizeof(uint8).} = enum
    WASM_I32, WASM_I64, WASM_F32, WASM_F64, WASM_ANYREF = 128, WASM_FUNCREF


proc wasm_valtype_new*(a1: ValKind): ptr WasmValType {.cdecl,
    importc: "wasm_valtype_new", dynlib: wasmer.}
proc wasm_valtype_kind*(a1: ptr WasmValType): ValKind {.cdecl,
    importc: "wasm_valtype_kind", dynlib: wasmer.}
## !!!Ignored construct:  static inline # ./wasm.h 3 4 [NewLine] _Bool # ./wasm.h [NewLine] wasm_valkind_is_num ( ValKind k ) { return k < WASM_ANYREF ; } static inline # ./wasm.h 3 4 [NewLine] _Bool # ./wasm.h [NewLine] wasm_valkind_is_ref ( wasm_valkind_t k ) { return k >= WASM_ANYREF ; } static inline # ./wasm.h 3 4 [NewLine] _Bool # ./wasm.h [NewLine] wasm_valtype_is_num ( const WasmValType * t ) { return wasm_valkind_is_num ( wasm_valtype_kind ( t ) ) ; } static inline # ./wasm.h 3 4 [NewLine] _Bool # ./wasm.h [NewLine] wasm_valtype_is_ref ( const WasmValType * t ) { return wasm_valkind_is_ref ( wasm_valtype_kind ( t ) ) ; } typedef struct WasmFuncType WasmFuncType ;
## Error: identifier expected, but got: #!!!

proc wasm_functype_delete*(a1: ptr WasmFuncType) {.cdecl,
    importc: "wasm_functype_delete", dynlib: wasmer.}
type
  wasm_functype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmFuncType]


proc wasm_functype_vec_new_empty*(`out`: ptr wasm_functype_vec_t) {.cdecl,
    importc: "wasm_functype_vec_new_empty", dynlib: wasmer.}
proc wasm_functype_vec_new_uninitialized*(`out`: ptr wasm_functype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_functype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_functype_vec_new*(`out`: ptr wasm_functype_vec_t; a2: csize_t;
                           a3: ptr ptr WasmFuncType) {.cdecl,
    importc: "wasm_functype_vec_new", dynlib: wasmer.}
proc wasm_functype_vec_copy*(`out`: ptr wasm_functype_vec_t;
                            a2: ptr wasm_functype_vec_t) {.cdecl,
    importc: "wasm_functype_vec_copy", dynlib: wasmer.}
proc wasm_functype_vec_delete*(a1: ptr wasm_functype_vec_t) {.cdecl,
    importc: "wasm_functype_vec_delete", dynlib: wasmer.}
proc wasm_functype_copy*(a1: ptr WasmFuncType): ptr WasmFuncType {.cdecl,
    importc: "wasm_functype_copy", dynlib: wasmer.}
proc wasm_functype_new*(params: ptr wasm_valtype_vec_t;
                       results: ptr wasm_valtype_vec_t): ptr WasmFuncType {.cdecl,
    importc: "wasm_functype_new", dynlib: wasmer.}
proc wasm_functype_params*(a1: ptr WasmFuncType): ptr wasm_valtype_vec_t {.cdecl,
    importc: "wasm_functype_params", dynlib: wasmer.}
proc wasm_functype_results*(a1: ptr WasmFuncType): ptr wasm_valtype_vec_t {.cdecl,
    importc: "wasm_functype_results", dynlib: wasmer.}

proc wasm_globaltype_delete*(a1: ptr WasmGlobalType) {.cdecl,
    importc: "wasm_globaltype_delete", dynlib: wasmer.}
type
  wasm_globaltype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmGlobalType]


proc wasm_globaltype_vec_new_empty*(`out`: ptr wasm_globaltype_vec_t) {.cdecl,
    importc: "wasm_globaltype_vec_new_empty", dynlib: wasmer.}
proc wasm_globaltype_vec_new_uninitialized*(`out`: ptr wasm_globaltype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_globaltype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_globaltype_vec_new*(`out`: ptr wasm_globaltype_vec_t; a2: csize_t;
                             a3: ptr ptr WasmGlobalType) {.cdecl,
    importc: "wasm_globaltype_vec_new", dynlib: wasmer.}
proc wasm_globaltype_vec_copy*(`out`: ptr wasm_globaltype_vec_t;
                              a2: ptr wasm_globaltype_vec_t) {.cdecl,
    importc: "wasm_globaltype_vec_copy", dynlib: wasmer.}
proc wasm_globaltype_vec_delete*(a1: ptr wasm_globaltype_vec_t) {.cdecl,
    importc: "wasm_globaltype_vec_delete", dynlib: wasmer.}
proc wasm_globaltype_copy*(a1: ptr WasmGlobalType): ptr WasmGlobalType {.cdecl,
    importc: "wasm_globaltype_copy", dynlib: wasmer.}
proc wasm_globaltype_new*(a1: ptr WasmValType; a2: Mutabillity): ptr WasmGlobalType {.
    cdecl, importc: "wasm_globaltype_new", dynlib: wasmer.}
proc wasm_globaltype_content*(a1: ptr WasmGlobalType): ptr WasmValType {.cdecl,
    importc: "wasm_globaltype_content", dynlib: wasmer.}
proc wasm_globaltype_mutability*(a1: ptr WasmGlobalType): Mutabillity {.
    cdecl, importc: "wasm_globaltype_mutability", dynlib: wasmer.}

proc wasm_tabletype_delete*(a1: ptr WasmTableType) {.cdecl,
    importc: "wasm_tabletype_delete", dynlib: wasmer.}
type
  wasm_tabletype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmTableType]


proc wasm_tabletype_vec_new_empty*(`out`: ptr wasm_tabletype_vec_t) {.cdecl,
    importc: "wasm_tabletype_vec_new_empty", dynlib: wasmer.}
proc wasm_tabletype_vec_new_uninitialized*(`out`: ptr wasm_tabletype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_tabletype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_tabletype_vec_new*(`out`: ptr wasm_tabletype_vec_t; a2: csize_t;
                            a3: ptr ptr WasmTableType) {.cdecl,
    importc: "wasm_tabletype_vec_new", dynlib: wasmer.}
proc wasm_tabletype_vec_copy*(`out`: ptr wasm_tabletype_vec_t;
                             a2: ptr wasm_tabletype_vec_t) {.cdecl,
    importc: "wasm_tabletype_vec_copy", dynlib: wasmer.}
proc wasm_tabletype_vec_delete*(a1: ptr wasm_tabletype_vec_t) {.cdecl,
    importc: "wasm_tabletype_vec_delete", dynlib: wasmer.}
proc wasm_tabletype_copy*(a1: ptr WasmTableType): ptr WasmTableType {.cdecl,
    importc: "wasm_tabletype_copy", dynlib: wasmer.}
proc wasm_tabletype_new*(a1: ptr WasmValType; a2: ptr wasm_limits_t): ptr WasmTableType {.
    cdecl, importc: "wasm_tabletype_new", dynlib: wasmer.}
proc wasm_tabletype_element*(a1: ptr WasmTableType): ptr WasmValType {.cdecl,
    importc: "wasm_tabletype_element", dynlib: wasmer.}
proc wasm_tabletype_limits*(a1: ptr WasmTableType): ptr wasm_limits_t {.cdecl,
    importc: "wasm_tabletype_limits", dynlib: wasmer.}

proc wasm_memorytype_delete*(a1: ptr WasmMemoryType) {.cdecl,
    importc: "wasm_memorytype_delete", dynlib: wasmer.}
type
  wasm_memorytype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmMemoryType]


proc wasm_memorytype_vec_new_empty*(`out`: ptr wasm_memorytype_vec_t) {.cdecl,
    importc: "wasm_memorytype_vec_new_empty", dynlib: wasmer.}
proc wasm_memorytype_vec_new_uninitialized*(`out`: ptr wasm_memorytype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_memorytype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_memorytype_vec_new*(`out`: ptr wasm_memorytype_vec_t; a2: csize_t;
                             a3: ptr ptr WasmMemoryType) {.cdecl,
    importc: "wasm_memorytype_vec_new", dynlib: wasmer.}
proc wasm_memorytype_vec_copy*(`out`: ptr wasm_memorytype_vec_t;
                              a2: ptr wasm_memorytype_vec_t) {.cdecl,
    importc: "wasm_memorytype_vec_copy", dynlib: wasmer.}
proc wasm_memorytype_vec_delete*(a1: ptr wasm_memorytype_vec_t) {.cdecl,
    importc: "wasm_memorytype_vec_delete", dynlib: wasmer.}
proc wasm_memorytype_copy*(a1: ptr WasmMemoryType): ptr WasmMemoryType {.cdecl,
    importc: "wasm_memorytype_copy", dynlib: wasmer.}
proc wasm_memorytype_new*(a1: ptr wasm_limits_t): ptr WasmMemoryType {.cdecl,
    importc: "wasm_memorytype_new", dynlib: wasmer.}
proc wasm_memorytype_limits*(a1: ptr WasmMemoryType): ptr wasm_limits_t {.cdecl,
    importc: "wasm_memorytype_limits", dynlib: wasmer.}

proc wasm_externtype_delete*(a1: ptr WasmExternType) {.cdecl,
    importc: "wasm_externtype_delete", dynlib: wasmer.}
type
  wasm_externtype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmExternType]


proc wasm_externtype_vec_new_empty*(`out`: ptr wasm_externtype_vec_t) {.cdecl,
    importc: "wasm_externtype_vec_new_empty", dynlib: wasmer.}
proc wasm_externtype_vec_new_uninitialized*(`out`: ptr wasm_externtype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_externtype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_externtype_vec_new*(`out`: ptr wasm_externtype_vec_t; a2: csize_t;
                             a3: ptr ptr WasmExternType) {.cdecl,
    importc: "wasm_externtype_vec_new", dynlib: wasmer.}
proc wasm_externtype_vec_copy*(`out`: ptr wasm_externtype_vec_t;
                              a2: ptr wasm_externtype_vec_t) {.cdecl,
    importc: "wasm_externtype_vec_copy", dynlib: wasmer.}
proc wasm_externtype_vec_delete*(a1: ptr wasm_externtype_vec_t) {.cdecl,
    importc: "wasm_externtype_vec_delete", dynlib: wasmer.}
proc wasm_externtype_copy*(a1: ptr WasmExternType): ptr WasmExternType {.cdecl,
    importc: "wasm_externtype_copy", dynlib: wasmer.}
type
  ExternKind* {.size: sizeof(uint8).} = enum
    WASM_EXTERN_FUNC, WASM_EXTERN_GLOBAL, WasmExternABLE, WASM_EXTERN_MEMORY


proc wasm_externtype_kind*(a1: ptr WasmExternType): ExternKind {.cdecl,
    importc: "wasm_externtype_kind", dynlib: wasmer.}
proc wasm_functype_as_externtype*(a1: ptr WasmFuncType): ptr WasmExternType {.
    cdecl, importc: "wasm_functype_as_externtype", dynlib: wasmer.}
proc wasm_globaltype_as_externtype*(a1: ptr WasmGlobalType): ptr WasmExternType {.
    cdecl, importc: "wasm_globaltype_as_externtype", dynlib: wasmer.}
proc wasm_tabletype_as_externtype*(a1: ptr WasmTableType): ptr WasmExternType {.
    cdecl, importc: "wasm_tabletype_as_externtype", dynlib: wasmer.}
proc wasm_memorytype_as_externtype*(a1: ptr WasmMemoryType): ptr WasmExternType {.
    cdecl, importc: "wasm_memorytype_as_externtype", dynlib: wasmer.}
proc wasm_externtype_as_functype*(a1: ptr WasmExternType): ptr WasmFuncType {.
    cdecl, importc: "wasm_externtype_as_functype", dynlib: wasmer.}
proc wasm_externtype_as_globaltype*(a1: ptr WasmExternType): ptr WasmGlobalType {.
    cdecl, importc: "wasm_externtype_as_globaltype", dynlib: wasmer.}
proc wasm_externtype_as_tabletype*(a1: ptr WasmExternType): ptr WasmTableType {.
    cdecl, importc: "wasm_externtype_as_tabletype", dynlib: wasmer.}
proc wasm_externtype_as_memorytype*(a1: ptr WasmExternType): ptr WasmMemoryType {.
    cdecl, importc: "wasm_externtype_as_memorytype", dynlib: wasmer.}
proc wasm_functype_as_externtype_const*(a1: ptr WasmFuncType): ptr WasmExternType {.
    cdecl, importc: "wasm_functype_as_externtype_const", dynlib: wasmer.}
proc wasm_globaltype_as_externtype_const*(a1: ptr WasmGlobalType): ptr WasmExternType {.
    cdecl, importc: "wasm_globaltype_as_externtype_const", dynlib: wasmer.}
proc wasm_tabletype_as_externtype_const*(a1: ptr WasmTableType): ptr WasmExternType {.
    cdecl, importc: "wasm_tabletype_as_externtype_const", dynlib: wasmer.}
proc wasm_memorytype_as_externtype_const*(a1: ptr WasmMemoryType): ptr WasmExternType {.
    cdecl, importc: "wasm_memorytype_as_externtype_const", dynlib: wasmer.}
proc wasm_externtype_as_functype_const*(a1: ptr WasmExternType): ptr WasmFuncType {.
    cdecl, importc: "wasm_externtype_as_functype_const", dynlib: wasmer.}
proc wasm_externtype_as_globaltype_const*(a1: ptr WasmExternType): ptr WasmGlobalType {.
    cdecl, importc: "wasm_externtype_as_globaltype_const", dynlib: wasmer.}
proc wasm_externtype_as_tabletype_const*(a1: ptr WasmExternType): ptr WasmTableType {.
    cdecl, importc: "wasm_externtype_as_tabletype_const", dynlib: wasmer.}
proc wasm_externtype_as_memorytype_const*(a1: ptr WasmExternType): ptr WasmMemoryType {.
    cdecl, importc: "wasm_externtype_as_memorytype_const", dynlib: wasmer.}

proc wasm_importtype_delete*(a1: ptr WasmImportType) {.cdecl,
    importc: "wasm_importtype_delete", dynlib: wasmer.}
type
  wasm_importtype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmImportType]


proc wasm_importtype_vec_new_empty*(`out`: ptr wasm_importtype_vec_t) {.cdecl,
    importc: "wasm_importtype_vec_new_empty", dynlib: wasmer.}
proc wasm_importtype_vec_new_uninitialized*(`out`: ptr wasm_importtype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_importtype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_importtype_vec_new*(`out`: ptr wasm_importtype_vec_t; a2: csize_t;
                             a3: ptr ptr WasmImportType) {.cdecl,
    importc: "wasm_importtype_vec_new", dynlib: wasmer.}
proc wasm_importtype_vec_copy*(`out`: ptr wasm_importtype_vec_t;
                              a2: ptr wasm_importtype_vec_t) {.cdecl,
    importc: "wasm_importtype_vec_copy", dynlib: wasmer.}
proc wasm_importtype_vec_delete*(a1: ptr wasm_importtype_vec_t) {.cdecl,
    importc: "wasm_importtype_vec_delete", dynlib: wasmer.}
proc wasm_importtype_copy*(a1: ptr WasmImportType): ptr WasmImportType {.cdecl,
    importc: "wasm_importtype_copy", dynlib: wasmer.}
proc wasm_importtype_new*(module: ptr wasm_name_t; name: ptr wasm_name_t;
                         a3: ptr WasmExternType): ptr WasmImportType {.cdecl,
    importc: "wasm_importtype_new", dynlib: wasmer.}
proc wasm_importtype_module*(a1: ptr WasmImportType): ptr wasm_name_t {.cdecl,
    importc: "wasm_importtype_module", dynlib: wasmer.}
proc wasm_importtype_name*(a1: ptr WasmImportType): ptr wasm_name_t {.cdecl,
    importc: "wasm_importtype_name", dynlib: wasmer.}
proc WasmImportTypeype*(a1: ptr WasmImportType): ptr WasmExternType {.cdecl,
    importc: "WasmImportTypeype", dynlib: wasmer.}

proc wasm_exporttype_delete*(a1: ptr WasmExportType) {.cdecl,
    importc: "wasm_exporttype_delete", dynlib: wasmer.}
type
  wasm_exporttype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmExportType]


proc wasm_exporttype_vec_new_empty*(`out`: ptr wasm_exporttype_vec_t) {.cdecl,
    importc: "wasm_exporttype_vec_new_empty", dynlib: wasmer.}
proc wasm_exporttype_vec_new_uninitialized*(`out`: ptr wasm_exporttype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_exporttype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_exporttype_vec_new*(`out`: ptr wasm_exporttype_vec_t; a2: csize_t;
                             a3: ptr ptr WasmExportType) {.cdecl,
    importc: "wasm_exporttype_vec_new", dynlib: wasmer.}
proc wasm_exporttype_vec_copy*(`out`: ptr wasm_exporttype_vec_t;
                              a2: ptr wasm_exporttype_vec_t) {.cdecl,
    importc: "wasm_exporttype_vec_copy", dynlib: wasmer.}
proc wasm_exporttype_vec_delete*(a1: ptr wasm_exporttype_vec_t) {.cdecl,
    importc: "wasm_exporttype_vec_delete", dynlib: wasmer.}
proc wasm_exporttype_copy*(a1: ptr WasmExportType): ptr WasmExportType {.cdecl,
    importc: "wasm_exporttype_copy", dynlib: wasmer.}
proc wasm_exporttype_new*(a1: ptr wasm_name_t; a2: ptr WasmExternType): ptr WasmExportType {.
    cdecl, importc: "wasm_exporttype_new", dynlib: wasmer.}
proc wasm_exporttype_name*(a1: ptr WasmExportType): ptr wasm_name_t {.cdecl,
    importc: "wasm_exporttype_name", dynlib: wasmer.}
proc WasmExportTypeype*(a1: ptr WasmExportType): ptr WasmExternType {.cdecl,
    importc: "WasmExportTypeype", dynlib: wasmer.}
discard "forward decl of WasmRef"
type
  INNER_C_UNION_expanded_826* {.bycopy, union.} = object
    i32*: int32
    i64*: int64
    f32*: float32
    f64*: float64
    `ref`*: ptr WasmRef

  WasmVal* {.bycopy.} = object
    case kind*: ValKind
    of WasmI32:
      i32*: int32
    of WasmI64:
      i64*: int64
    of WasmF32:
      f32*: float32
    of WasmF64:
      f64*: float64
    else:
      theRef*: ptr WasmRef


proc wasm_val_delete*(v: ptr WasmVal) {.cdecl, importc: "wasm_val_delete",
                                       dynlib: wasmer.}
proc wasm_val_copy*(`out`: ptr WasmVal; a2: ptr WasmVal) {.cdecl,
    importc: "wasm_val_copy", dynlib: wasmer.}
type
  wasm_val_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[WasmVal]


proc wasm_val_vec_new_empty*(`out`: ptr wasm_val_vec_t) {.cdecl,
    importc: "wasm_val_vec_new_empty", dynlib: wasmer.}
proc wasm_val_vec_new_uninitialized*(`out`: ptr wasm_val_vec_t; a2: csize_t) {.cdecl,
    importc: "wasm_val_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_val_vec_new*(`out`: ptr wasm_val_vec_t; a2: csize_t; a3: ptr WasmVal) {.
    cdecl, importc: "wasm_val_vec_new", dynlib: wasmer.}
proc wasm_val_vec_copy*(`out`: ptr wasm_val_vec_t; a2: ptr wasm_val_vec_t) {.cdecl,
    importc: "wasm_val_vec_copy", dynlib: wasmer.}
proc wasm_val_vec_delete*(a1: ptr wasm_val_vec_t) {.cdecl,
    importc: "wasm_val_vec_delete", dynlib: wasmer.}

proc wasm_ref_delete*(a1: ptr WasmRef) {.cdecl, importc: "wasm_ref_delete",
                                        dynlib: wasmer.}
proc wasm_ref_copy*(a1: ptr WasmRef): ptr WasmRef {.cdecl,
    importc: "wasm_ref_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_ref_same ( const WasmRef * , const WasmRef * ) ;
## Error: expected ';'!!!

proc wasm_ref_get_host_info*(a1: ptr WasmRef): pointer {.cdecl,
    importc: "wasm_ref_get_host_info", dynlib: wasmer.}
proc wasm_ref_set_host_info*(a1: ptr WasmRef; a2: pointer) {.cdecl,
    importc: "wasm_ref_set_host_info", dynlib: wasmer.}
proc wasm_ref_set_host_info_with_finalizer*(a1: ptr WasmRef; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_ref_set_host_info_with_finalizer",
                                   dynlib: wasmer.}

proc wasm_frame_delete*(a1: ptr WasmFrame) {.cdecl, importc: "wasm_frame_delete",
    dynlib: wasmer.}
type
  wasm_frame_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmFrame]


proc wasm_frame_vec_new_empty*(`out`: ptr wasm_frame_vec_t) {.cdecl,
    importc: "wasm_frame_vec_new_empty", dynlib: wasmer.}
proc wasm_frame_vec_new_uninitialized*(`out`: ptr wasm_frame_vec_t; a2: csize_t) {.
    cdecl, importc: "wasm_frame_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_frame_vec_new*(`out`: ptr wasm_frame_vec_t; a2: csize_t;
                        a3: ptr ptr WasmFrame) {.cdecl,
    importc: "wasm_frame_vec_new", dynlib: wasmer.}
proc wasm_frame_vec_copy*(`out`: ptr wasm_frame_vec_t; a2: ptr wasm_frame_vec_t) {.
    cdecl, importc: "wasm_frame_vec_copy", dynlib: wasmer.}
proc wasm_frame_vec_delete*(a1: ptr wasm_frame_vec_t) {.cdecl,
    importc: "wasm_frame_vec_delete", dynlib: wasmer.}
proc wasm_frame_copy*(a1: ptr WasmFrame): ptr WasmFrame {.cdecl,
    importc: "wasm_frame_copy", dynlib: wasmer.}
proc wasm_frame_instance*(a1: ptr WasmFrame): ptr WasmInstance {.cdecl,
    importc: "wasm_frame_instance", dynlib: wasmer.}
proc wasm_frame_func_index*(a1: ptr WasmFrame): uint32 {.cdecl,
    importc: "wasm_frame_func_index", dynlib: wasmer.}
proc wasm_frame_func_offset*(a1: ptr WasmFrame): csize_t {.cdecl,
    importc: "wasm_frame_func_offset", dynlib: wasmer.}
proc wasm_frame_module_offset*(a1: ptr WasmFrame): csize_t {.cdecl,
    importc: "wasm_frame_module_offset", dynlib: wasmer.}
type
  wasm_message_t* = wasm_name_t

proc wasm_trap_delete*(a1: ptr WasmTrap) {.cdecl, importc: "wasm_trap_delete",
    dynlib: wasmer.}
proc wasm_trap_copy*(a1: ptr WasmTrap): ptr WasmTrap {.cdecl,
    importc: "wasm_trap_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_trap_same ( const WasmTrap * , const WasmTrap * ) ;
## Error: expected ';'!!!

proc wasm_trap_get_host_info*(a1: ptr WasmTrap): pointer {.cdecl,
    importc: "wasm_trap_get_host_info", dynlib: wasmer.}
proc wasm_trap_set_host_info*(a1: ptr WasmTrap; a2: pointer) {.cdecl,
    importc: "wasm_trap_set_host_info", dynlib: wasmer.}
proc wasm_trap_set_host_info_with_finalizer*(a1: ptr WasmTrap; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_trap_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_trap_as_ref*(a1: ptr WasmTrap): ptr WasmRef {.cdecl,
    importc: "wasm_trap_as_ref", dynlib: wasmer.}
proc wasm_ref_as_trap*(a1: ptr WasmRef): ptr WasmTrap {.cdecl,
    importc: "wasm_ref_as_trap", dynlib: wasmer.}
proc wasm_trap_as_ref_const*(a1: ptr WasmTrap): ptr WasmRef {.cdecl,
    importc: "wasm_trap_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_trap_const*(a1: ptr WasmRef): ptr WasmTrap {.cdecl,
    importc: "wasm_ref_as_trap_const", dynlib: wasmer.}
proc wasm_trap_new*(store: ptr WasmStore; a2: ptr wasm_message_t): ptr WasmTrap {.
    cdecl, importc: "wasm_trap_new", dynlib: wasmer.}
proc wasm_trap_message*(a1: ptr WasmTrap; `out`: ptr wasm_message_t) {.cdecl,
    importc: "wasm_trap_message", dynlib: wasmer.}
proc wasm_trap_origin*(a1: ptr WasmTrap): ptr WasmFrame {.cdecl,
    importc: "wasm_trap_origin", dynlib: wasmer.}
proc WasmTraprace*(a1: ptr WasmTrap; `out`: ptr wasm_frame_vec_t) {.cdecl,
    importc: "WasmTraprace", dynlib: wasmer.}

proc wasm_foreign_delete*(a1: ptr WasmForeign) {.cdecl,
    importc: "wasm_foreign_delete", dynlib: wasmer.}
proc wasm_foreign_copy*(a1: ptr WasmForeign): ptr WasmForeign {.cdecl,
    importc: "wasm_foreign_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_foreign_same ( const WasmForeign * , const WasmForeign * ) ;
## Error: expected ';'!!!

proc wasm_foreign_get_host_info*(a1: ptr WasmForeign): pointer {.cdecl,
    importc: "wasm_foreign_get_host_info", dynlib: wasmer.}
proc wasm_foreign_set_host_info*(a1: ptr WasmForeign; a2: pointer) {.cdecl,
    importc: "wasm_foreign_set_host_info", dynlib: wasmer.}
proc wasm_foreign_set_host_info_with_finalizer*(a1: ptr WasmForeign; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_foreign_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_foreign_as_ref*(a1: ptr WasmForeign): ptr WasmRef {.cdecl,
    importc: "wasm_foreign_as_ref", dynlib: wasmer.}
proc wasm_ref_as_foreign*(a1: ptr WasmRef): ptr WasmForeign {.cdecl,
    importc: "wasm_ref_as_foreign", dynlib: wasmer.}
proc wasm_foreign_as_ref_const*(a1: ptr WasmForeign): ptr WasmRef {.cdecl,
    importc: "wasm_foreign_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_foreign_const*(a1: ptr WasmRef): ptr WasmForeign {.cdecl,
    importc: "wasm_ref_as_foreign_const", dynlib: wasmer.}
proc wasm_foreign_new*(a1: ptr WasmStore): ptr WasmForeign {.cdecl,
    importc: "wasm_foreign_new", dynlib: wasmer.}

proc wasm_module_delete*(a1: ptr WasmModule) {.cdecl,
    importc: "wasm_module_delete", dynlib: wasmer.}
proc wasm_module_copy*(a1: ptr WasmModule): ptr WasmModule {.cdecl,
    importc: "wasm_module_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_module_same ( const WasmModule * , const WasmModule * ) ;
## Error: expected ';'!!!

proc wasm_module_get_host_info*(a1: ptr WasmModule): pointer {.cdecl,
    importc: "wasm_module_get_host_info", dynlib: wasmer.}
proc wasm_module_set_host_info*(a1: ptr WasmModule; a2: pointer) {.cdecl,
    importc: "wasm_module_set_host_info", dynlib: wasmer.}
proc wasm_module_set_host_info_with_finalizer*(a1: ptr WasmModule; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_module_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_module_as_ref*(a1: ptr WasmModule): ptr WasmRef {.cdecl,
    importc: "wasm_module_as_ref", dynlib: wasmer.}
proc wasm_ref_as_module*(a1: ptr WasmRef): ptr WasmModule {.cdecl,
    importc: "wasm_ref_as_module", dynlib: wasmer.}
proc wasm_module_as_ref_const*(a1: ptr WasmModule): ptr WasmRef {.cdecl,
    importc: "wasm_module_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_module_const*(a1: ptr WasmRef): ptr WasmModule {.cdecl,
    importc: "wasm_ref_as_module_const", dynlib: wasmer.}

proc wasm_shared_module_delete*(a1: ptr WasmSharedModule) {.cdecl,
    importc: "wasm_shared_module_delete", dynlib: wasmer.}
proc wasm_module_share*(a1: ptr WasmModule): ptr WasmSharedModule {.cdecl,
    importc: "wasm_module_share", dynlib: wasmer.}
proc wasm_module_obtain*(a1: ptr WasmStore; a2: ptr WasmSharedModule): ptr WasmModule {.
    cdecl, importc: "wasm_module_obtain", dynlib: wasmer.}
proc wasm_module_new*(a1: ptr WasmStore; binary: ptr wasm_byte_vec_t): ptr WasmModule {.
    cdecl, importc: "wasm_module_new", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_module_validate ( WasmStore * , const wasm_byte_vec_t * binary ) ;
## Error: expected ';'!!!

proc wasm_module_imports*(a1: ptr WasmModule; `out`: ptr wasm_importtype_vec_t) {.
    cdecl, importc: "wasm_module_imports", dynlib: wasmer.}
proc wasm_module_exports*(a1: ptr WasmModule; `out`: ptr wasm_exporttype_vec_t) {.
    cdecl, importc: "wasm_module_exports", dynlib: wasmer.}
proc wasm_module_serialize*(a1: ptr WasmModule; `out`: ptr wasm_byte_vec_t) {.cdecl,
    importc: "wasm_module_serialize", dynlib: wasmer.}
proc wasm_module_deserialize*(a1: ptr WasmStore; a2: ptr wasm_byte_vec_t): ptr WasmModule {.
    cdecl, importc: "wasm_module_deserialize", dynlib: wasmer.}

proc wasm_func_delete*(a1: ptr WasmFunc) {.cdecl, importc: "wasm_func_delete",
    dynlib: wasmer.}
proc wasm_func_copy*(a1: ptr WasmFunc): ptr WasmFunc {.cdecl,
    importc: "wasm_func_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_func_same ( const WasmFunc * , const WasmFunc * ) ;
## Error: expected ';'!!!

proc wasm_func_get_host_info*(a1: ptr WasmFunc): pointer {.cdecl,
    importc: "wasm_func_get_host_info", dynlib: wasmer.}
proc wasm_func_set_host_info*(a1: ptr WasmFunc; a2: pointer) {.cdecl,
    importc: "wasm_func_set_host_info", dynlib: wasmer.}
proc wasm_func_set_host_info_with_finalizer*(a1: ptr WasmFunc; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_func_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_func_as_ref*(a1: ptr WasmFunc): ptr WasmRef {.cdecl,
    importc: "wasm_func_as_ref", dynlib: wasmer.}
proc wasm_ref_as_func*(a1: ptr WasmRef): ptr WasmFunc {.cdecl,
    importc: "wasm_ref_as_func", dynlib: wasmer.}
proc wasm_func_as_ref_const*(a1: ptr WasmFunc): ptr WasmRef {.cdecl,
    importc: "wasm_func_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_func_const*(a1: ptr WasmRef): ptr WasmFunc {.cdecl,
    importc: "wasm_ref_as_func_const", dynlib: wasmer.}
type
  wasm_func_callback_t* = proc (args: ptr wasm_val_vec_t; results: ptr wasm_val_vec_t): ptr WasmTrap {.
      cdecl.}
  wasm_func_callback_with_env_t* = proc (env: pointer; args: ptr wasm_val_vec_t;
                                      results: ptr wasm_val_vec_t): ptr WasmTrap {.
      cdecl.}

proc wasm_func_new*(a1: ptr WasmStore; a2: ptr WasmFuncType;
                   a3: wasm_func_callback_t): ptr WasmFunc {.cdecl,
    importc: "wasm_func_new", dynlib: wasmer.}
proc wasm_func_new_with_env*(a1: ptr WasmStore; `type`: ptr WasmFuncType;
                            a3: wasm_func_callback_with_env_t; env: pointer;
                            finalizer: proc (a1: pointer) {.cdecl.}): ptr WasmFunc {.
    cdecl, importc: "wasm_func_new_with_env", dynlib: wasmer.}
proc WasmFuncype*(a1: ptr WasmFunc): ptr WasmFuncType {.cdecl,
    importc: "WasmFuncype", dynlib: wasmer.}
proc wasm_func_param_arity*(a1: ptr WasmFunc): csize_t {.cdecl,
    importc: "wasm_func_param_arity", dynlib: wasmer.}
proc wasm_func_result_arity*(a1: ptr WasmFunc): csize_t {.cdecl,
    importc: "wasm_func_result_arity", dynlib: wasmer.}
proc wasm_func_call*(a1: ptr WasmFunc; args: ptr wasm_val_vec_t;
                    results: ptr wasm_val_vec_t): ptr WasmTrap {.cdecl,
    importc: "wasm_func_call", dynlib: wasmer.}

proc wasm_global_delete*(a1: ptr WasmGlobal) {.cdecl,
    importc: "wasm_global_delete", dynlib: wasmer.}
proc wasm_global_copy*(a1: ptr WasmGlobal): ptr WasmGlobal {.cdecl,
    importc: "wasm_global_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_global_same ( const WasmGlobal * , const WasmGlobal * ) ;
## Error: expected ';'!!!

proc wasm_global_get_host_info*(a1: ptr WasmGlobal): pointer {.cdecl,
    importc: "wasm_global_get_host_info", dynlib: wasmer.}
proc wasm_global_set_host_info*(a1: ptr WasmGlobal; a2: pointer) {.cdecl,
    importc: "wasm_global_set_host_info", dynlib: wasmer.}
proc wasm_global_set_host_info_with_finalizer*(a1: ptr WasmGlobal; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_global_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_global_as_ref*(a1: ptr WasmGlobal): ptr WasmRef {.cdecl,
    importc: "wasm_global_as_ref", dynlib: wasmer.}
proc wasm_ref_as_global*(a1: ptr WasmRef): ptr WasmGlobal {.cdecl,
    importc: "wasm_ref_as_global", dynlib: wasmer.}
proc wasm_global_as_ref_const*(a1: ptr WasmGlobal): ptr WasmRef {.cdecl,
    importc: "wasm_global_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_global_const*(a1: ptr WasmRef): ptr WasmGlobal {.cdecl,
    importc: "wasm_ref_as_global_const", dynlib: wasmer.}
proc wasm_global_new*(a1: ptr WasmStore; a2: ptr WasmGlobalType;
                     a3: ptr WasmVal): ptr WasmGlobal {.cdecl,
    importc: "wasm_global_new", dynlib: wasmer.}
proc wasm_global_type*(a1: ptr WasmGlobal): ptr WasmGlobalType {.cdecl,
    importc: "wasm_global_type", dynlib: wasmer.}
proc wasm_global_get*(a1: ptr WasmGlobal; `out`: ptr WasmVal) {.cdecl,
    importc: "wasm_global_get", dynlib: wasmer.}
proc wasm_global_set*(a1: ptr WasmGlobal; a2: ptr WasmVal) {.cdecl,
    importc: "wasm_global_set", dynlib: wasmer.}

proc wasm_table_delete*(a1: ptr WasmTable) {.cdecl, importc: "wasm_table_delete",
    dynlib: wasmer.}
proc wasm_table_copy*(a1: ptr WasmTable): ptr WasmTable {.cdecl,
    importc: "wasm_table_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_table_same ( const WasmTable * , const WasmTable * ) ;
## Error: expected ';'!!!

proc wasm_table_get_host_info*(a1: ptr WasmTable): pointer {.cdecl,
    importc: "wasm_table_get_host_info", dynlib: wasmer.}
proc wasm_table_set_host_info*(a1: ptr WasmTable; a2: pointer) {.cdecl,
    importc: "wasm_table_set_host_info", dynlib: wasmer.}
proc wasm_table_set_host_info_with_finalizer*(a1: ptr WasmTable; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_table_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_table_as_ref*(a1: ptr WasmTable): ptr WasmRef {.cdecl,
    importc: "wasm_table_as_ref", dynlib: wasmer.}
proc wasm_ref_as_table*(a1: ptr WasmRef): ptr WasmTable {.cdecl,
    importc: "wasm_ref_as_table", dynlib: wasmer.}
proc wasm_table_as_ref_const*(a1: ptr WasmTable): ptr WasmRef {.cdecl,
    importc: "wasm_table_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_table_const*(a1: ptr WasmRef): ptr WasmTable {.cdecl,
    importc: "wasm_ref_as_table_const", dynlib: wasmer.}
type
  wasm_table_size_t* = uint32

proc wasm_table_new*(a1: ptr WasmStore; a2: ptr WasmTableType;
                    init: ptr WasmRef): ptr WasmTable {.cdecl,
    importc: "wasm_table_new", dynlib: wasmer.}
proc wasm_table_type*(a1: ptr WasmTable): ptr WasmTableType {.cdecl,
    importc: "WasmTableype", dynlib: wasmer.}
proc wasm_table_get*(a1: ptr WasmTable; index: wasm_table_size_t): ptr WasmRef {.
    cdecl, importc: "wasm_table_get", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_table_set ( WasmTable * , wasm_table_size_t index , WasmRef * ) ;
## Error: expected ';'!!!

proc wasm_table_size*(a1: ptr WasmTable): wasm_table_size_t {.cdecl,
    importc: "wasm_table_size", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_table_grow ( WasmTable * , wasm_table_size_t delta , WasmRef * init ) ;
## Error: expected ';'!!!


proc wasm_memory_delete*(a1: ptr WasmMemory) {.cdecl,
    importc: "wasm_memory_delete", dynlib: wasmer.}
proc wasm_memory_copy*(a1: ptr WasmMemory): ptr WasmMemory {.cdecl,
    importc: "wasm_memory_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_memory_same ( const WasmMemory * , const WasmMemory * ) ;
## Error: expected ';'!!!

proc wasm_memory_get_host_info*(a1: ptr WasmMemory): pointer {.cdecl,
    importc: "wasm_memory_get_host_info", dynlib: wasmer.}
proc wasm_memory_set_host_info*(a1: ptr WasmMemory; a2: pointer) {.cdecl,
    importc: "wasm_memory_set_host_info", dynlib: wasmer.}
proc wasm_memory_set_host_info_with_finalizer*(a1: ptr WasmMemory; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_memory_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_memory_as_ref*(a1: ptr WasmMemory): ptr WasmRef {.cdecl,
    importc: "wasm_memory_as_ref", dynlib: wasmer.}
proc wasm_ref_as_memory*(a1: ptr WasmRef): ptr WasmMemory {.cdecl,
    importc: "wasm_ref_as_memory", dynlib: wasmer.}
proc wasm_memory_as_ref_const*(a1: ptr WasmMemory): ptr WasmRef {.cdecl,
    importc: "wasm_memory_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_memory_const*(a1: ptr WasmRef): ptr WasmMemory {.cdecl,
    importc: "wasm_ref_as_memory_const", dynlib: wasmer.}
type
  wasm_memory_pages_t* = uint32

#var MEMORY_PAGE_SIZE* {.importc: "MEMORY_PAGE_SIZE", dynlib: wasmer.}: csize_t

proc wasm_memory_new*(a1: ptr WasmStore; a2: ptr WasmMemoryType): ptr WasmMemory {.
    cdecl, importc: "wasm_memory_new", dynlib: wasmer.}
proc wasm_memory_type*(a1: ptr WasmMemory): ptr WasmMemoryType {.cdecl,
    importc: "wasm_memory_type", dynlib: wasmer.}
proc wasm_memory_data*(a1: ptr WasmMemory): ptr byte {.cdecl,
    importc: "wasm_memory_data", dynlib: wasmer.}
proc wasm_memory_data_size*(a1: ptr WasmMemory): csize_t {.cdecl,
    importc: "wasm_memory_data_size", dynlib: wasmer.}
proc wasm_memory_size*(a1: ptr WasmMemory): wasm_memory_pages_t {.cdecl,
    importc: "wasm_memory_size", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_memory_grow ( WasmMemory * , wasm_memory_pages_t delta ) ;
## Error: expected ';'!!!


proc wasm_extern_delete*(a1: ptr WasmExtern) {.cdecl,
    importc: "wasm_extern_delete", dynlib: wasmer.}
proc wasm_extern_copy*(a1: ptr WasmExtern): ptr WasmExtern {.cdecl,
    importc: "wasm_extern_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_extern_same ( const WasmExtern * , const WasmExtern * ) ;
## Error: expected ';'!!!

proc wasm_extern_get_host_info*(a1: ptr WasmExtern): pointer {.cdecl,
    importc: "wasm_extern_get_host_info", dynlib: wasmer.}
proc wasm_extern_set_host_info*(a1: ptr WasmExtern; a2: pointer) {.cdecl,
    importc: "wasm_extern_set_host_info", dynlib: wasmer.}
proc wasm_extern_set_host_info_with_finalizer*(a1: ptr WasmExtern; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_extern_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_extern_as_ref*(a1: ptr WasmExtern): ptr WasmRef {.cdecl,
    importc: "wasm_extern_as_ref", dynlib: wasmer.}
proc wasm_ref_as_extern*(a1: ptr WasmRef): ptr WasmExtern {.cdecl,
    importc: "wasm_ref_as_extern", dynlib: wasmer.}
proc wasm_extern_as_ref_const*(a1: ptr WasmExtern): ptr WasmRef {.cdecl,
    importc: "wasm_extern_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_extern_const*(a1: ptr WasmRef): ptr WasmExtern {.cdecl,
    importc: "wasm_ref_as_extern_const", dynlib: wasmer.}
type
  wasm_extern_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr WasmExtern]


proc wasm_extern_vec_new_empty*(`out`: ptr wasm_extern_vec_t) {.cdecl,
    importc: "wasm_extern_vec_new_empty", dynlib: wasmer.}
proc wasm_extern_vec_new_uninitialized*(`out`: ptr wasm_extern_vec_t; a2: csize_t) {.
    cdecl, importc: "wasm_extern_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_extern_vec_new*(`out`: ptr wasm_extern_vec_t; a2: csize_t;
                         a3: ptr ptr WasmExtern) {.cdecl,
    importc: "wasm_extern_vec_new", dynlib: wasmer.}
proc wasm_extern_vec_copy*(`out`: ptr wasm_extern_vec_t; a2: ptr wasm_extern_vec_t) {.
    cdecl, importc: "wasm_extern_vec_copy", dynlib: wasmer.}
proc wasm_extern_vec_delete*(a1: ptr wasm_extern_vec_t) {.cdecl,
    importc: "wasm_extern_vec_delete", dynlib: wasmer.}
proc wasm_extern_kind*(a1: ptr WasmExtern): ExternKind {.cdecl,
    importc: "wasm_extern_kind", dynlib: wasmer.}
proc wasm_extern_type*(a1: ptr WasmExtern): ptr WasmExternType {.cdecl,
    importc: "wasm_extern_type", dynlib: wasmer.}
proc wasm_func_as_extern*(a1: ptr WasmFunc): ptr WasmExtern {.cdecl,
    importc: "wasm_func_as_extern", dynlib: wasmer.}
proc wasm_global_as_extern*(a1: ptr WasmGlobal): ptr WasmExtern {.cdecl,
    importc: "wasm_global_as_extern", dynlib: wasmer.}
proc wasm_table_as_extern*(a1: ptr WasmTable): ptr WasmExtern {.cdecl,
    importc: "wasm_table_as_extern", dynlib: wasmer.}
proc wasm_memory_as_extern*(a1: ptr WasmMemory): ptr WasmExtern {.cdecl,
    importc: "wasm_memory_as_extern", dynlib: wasmer.}
proc wasm_extern_as_func*(a1: ptr WasmExtern): ptr WasmFunc {.cdecl,
    importc: "wasm_extern_as_func", dynlib: wasmer.}
proc wasm_extern_as_global*(a1: ptr WasmExtern): ptr WasmGlobal {.cdecl,
    importc: "wasm_extern_as_global", dynlib: wasmer.}
proc wasm_extern_as_table*(a1: ptr WasmExtern): ptr WasmTable {.cdecl,
    importc: "wasm_extern_as_table", dynlib: wasmer.}
proc wasm_extern_as_memory*(a1: ptr WasmExtern): ptr WasmMemory {.cdecl,
    importc: "wasm_extern_as_memory", dynlib: wasmer.}
proc wasm_func_as_extern_const*(a1: ptr WasmFunc): ptr WasmExtern {.cdecl,
    importc: "wasm_func_as_extern_const", dynlib: wasmer.}
proc wasm_global_as_extern_const*(a1: ptr WasmGlobal): ptr WasmExtern {.cdecl,
    importc: "wasm_global_as_extern_const", dynlib: wasmer.}
proc wasm_table_as_extern_const*(a1: ptr WasmTable): ptr WasmExtern {.cdecl,
    importc: "wasm_table_as_extern_const", dynlib: wasmer.}
proc wasm_memory_as_extern_const*(a1: ptr WasmMemory): ptr WasmExtern {.cdecl,
    importc: "wasm_memory_as_extern_const", dynlib: wasmer.}
proc wasm_extern_as_func_const*(a1: ptr WasmExtern): ptr WasmFunc {.cdecl,
    importc: "wasm_extern_as_func_const", dynlib: wasmer.}
proc wasm_extern_as_global_const*(a1: ptr WasmExtern): ptr WasmGlobal {.cdecl,
    importc: "wasm_extern_as_global_const", dynlib: wasmer.}
proc wasm_extern_as_table_const*(a1: ptr WasmExtern): ptr WasmTable {.cdecl,
    importc: "wasm_extern_as_table_const", dynlib: wasmer.}
proc wasm_extern_as_memory_const*(a1: ptr WasmExtern): ptr WasmMemory {.cdecl,
    importc: "wasm_extern_as_memory_const", dynlib: wasmer.}

proc wasm_instance_delete*(a1: ptr WasmInstance) {.cdecl,
    importc: "wasm_instance_delete", dynlib: wasmer.}
proc wasm_instance_copy*(a1: ptr WasmInstance): ptr WasmInstance {.cdecl,
    importc: "wasm_instance_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_instance_same ( const WasmInstance * , const WasmInstance * ) ;
## Error: expected ';'!!!

proc wasm_instance_get_host_info*(a1: ptr WasmInstance): pointer {.cdecl,
    importc: "wasm_instance_get_host_info", dynlib: wasmer.}
proc wasm_instance_set_host_info*(a1: ptr WasmInstance; a2: pointer) {.cdecl,
    importc: "wasm_instance_set_host_info", dynlib: wasmer.}
proc wasm_instance_set_host_info_with_finalizer*(a1: ptr WasmInstance;
    a2: pointer; a3: proc (a1: pointer) {.cdecl.}) {.cdecl,
    importc: "wasm_instance_set_host_info_with_finalizer", dynlib: wasmer.}
proc wasm_instance_as_ref*(a1: ptr WasmInstance): ptr WasmRef {.cdecl,
    importc: "wasm_instance_as_ref", dynlib: wasmer.}
proc wasm_ref_as_instance*(a1: ptr WasmRef): ptr WasmInstance {.cdecl,
    importc: "wasm_ref_as_instance", dynlib: wasmer.}
proc wasm_instance_as_ref_const*(a1: ptr WasmInstance): ptr WasmRef {.cdecl,
    importc: "wasm_instance_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_instance_const*(a1: ptr WasmRef): ptr WasmInstance {.cdecl,
    importc: "wasm_ref_as_instance_const", dynlib: wasmer.}
proc wasm_instance_new*(a1: ptr WasmStore; a2: ptr WasmModule;
                       imports: ptr wasm_extern_vec_t; a4: ptr ptr WasmTrap): ptr WasmInstance {.
    cdecl, importc: "wasm_instance_new", dynlib: wasmer.}
proc wasm_instance_exports*(a1: ptr WasmInstance; `out`: ptr wasm_extern_vec_t) {.
    cdecl, importc: "wasm_instance_exports", dynlib: wasmer.}
proc wasm_valtype_new_i32*(): ptr WasmValType {.inline, cdecl.} =
  return wasm_valtype_new(WASM_I32)

proc wasm_valtype_new_i64*(): ptr WasmValType {.inline, cdecl.} =
  return wasm_valtype_new(WASM_I64)

proc wasm_valtype_new_f32*(): ptr WasmValType {.inline, cdecl.} =
  return wasm_valtype_new(WASM_F32)

proc wasm_valtype_new_f64*(): ptr WasmValType {.inline, cdecl.} =
  return wasm_valtype_new(WASM_F64)

proc wasm_valtype_new_anyref*(): ptr WasmValType {.inline, cdecl.} =
  return wasm_valtype_new(WASM_ANYREF)

proc wasm_valtype_new_funcref*(): ptr WasmValType {.inline, cdecl.} =
  return wasm_valtype_new(WASM_FUNCREF)
#[
# These are silly with Nim, we have open arrays to do this automagically
proc wasm_functype_new_0_0*(): ptr WasmFuncType {.inline, cdecl.} =
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new_empty(addr(params))
  wasm_valtype_vec_new_empty(addr(results))
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_1_0*(p: ptr WasmValType): ptr WasmFuncType {.inline, cdecl.} =
  var ps: array[1, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 1, ps[0].addr)
  wasm_valtype_vec_new_empty(addr(results))
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_2_0*(p1: ptr WasmValType; p2: ptr WasmValType): ptr WasmFuncType {.
    inline, cdecl.} =
  var ps: array[2, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 2, ps[0].addr)
  wasm_valtype_vec_new_empty(addr(results))
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_3_0*(p1: ptr WasmValType; p2: ptr WasmValType;
                           p3: ptr WasmValType): ptr WasmFuncType {.inline,
    cdecl.} =
  var ps: array[3, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 3, ps[0].addr)
  wasm_valtype_vec_new_empty(addr(results))
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_0_1*(r: ptr WasmValType): ptr WasmFuncType {.inline, cdecl.} =
  var rs: array[1, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new_empty(addr(params))
  wasm_valtype_vec_new(addr(results), 1, rs[0].addr)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_1_1*(p: ptr WasmValType; r: ptr WasmValType): ptr WasmFuncType {.
    inline, cdecl.} =
  var ps: array[1, ptr WasmValType]
  var rs: array[1, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 1, ps[0].addr)
  wasm_valtype_vec_new(addr(results), 1, rs[0].addr)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_2_1*(p1: ptr WasmValType; p2: ptr WasmValType;
                           r: ptr WasmValType): ptr WasmFuncType {.inline, cdecl.} =
  var ps: array[2, ptr WasmValType]
  var rs: array[1, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 2, ps[0].addr)
  wasm_valtype_vec_new(addr(results), 1, rs[0].addr)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_3_1*(p1: ptr WasmValType; p2: ptr WasmValType;
                           p3: ptr WasmValType; r: ptr WasmValType): ptr WasmFuncType {.
    inline, cdecl.} =
  var ps: array[3, ptr WasmValType]
  var rs: array[1, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 3, ps)
  wasm_valtype_vec_new(addr(results), 1, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_0_2*(r1: ptr WasmValType; r2: ptr WasmValType): ptr WasmFuncType {.
    inline, cdecl.} =
  var rs: array[2, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new_empty(addr(params))
  wasm_valtype_vec_new(addr(results), 2, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_1_2*(p: ptr WasmValType; r1: ptr WasmValType;
                           r2: ptr WasmValType): ptr WasmFuncType {.inline,
    cdecl.} =
  var ps: array[1, ptr WasmValType]
  var rs: array[2, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 1, ps)
  wasm_valtype_vec_new(addr(results), 2, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_2_2*(p1: ptr WasmValType; p2: ptr WasmValType;
                           r1: ptr WasmValType; r2: ptr WasmValType): ptr WasmFuncType {.
    inline, cdecl.} =
  var ps: array[2, ptr WasmValType]
  var rs: array[2, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 2, ps)
  wasm_valtype_vec_new(addr(results), 2, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_3_2*(p1: ptr WasmValType; p2: ptr WasmValType;
                           p3: ptr WasmValType; r1: ptr WasmValType;
                           r2: ptr WasmValType): ptr WasmFuncType {.inline,
    cdecl.} =
  var ps: array[3, ptr WasmValType]
  var rs: array[2, ptr WasmValType]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 3, ps)
  wasm_valtype_vec_new(addr(results), 2, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_val_init_ptr*(`out`: ptr WasmVal; p: pointer) {.inline, cdecl.} =
  `out`.kind = WASM_I64
  `out`.`of`.i64 = cast[intptr_t](p)

proc wasm_val_ptr*(val: ptr WasmVal): pointer {.inline, cdecl.} =
  return cast[pointer](cast[intptr_t](val.`of`.i64))
]#
