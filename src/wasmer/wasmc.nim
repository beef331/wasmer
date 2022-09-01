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

defineWasmType wasm_config_t
defineWasmType wasm_engine_t
defineWasmType wasm_store_t
defineWasmType wasm_valtype_t
defineWasmType wasm_functype_t
defineWasmType wasm_globaltype_t
defineWasmType wasm_tabletype_t
defineWasmType wasm_memorytype_t
defineWasmType wasm_externtype_t
defineWasmType wasm_importtype_t
defineWasmType wasm_exporttype_t
defineWasmType wasm_ref_t
defineWasmType wasm_frame_t
defineWasmType wasm_trap_t
defineWasmType wasm_foreign_t
defineWasmType wasm_module_t
defineWasmType wasm_shared_module_t
defineWasmType wasm_instance_t
defineWasmType wasm_func_t
defineWasmType wasm_global_t
defineWasmType wasm_table_t
defineWasmType wasm_memory_t
defineWasmType wasm_extern_t
defineWasmType wasm_import_t
defineWasmType wasm_export_t


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


proc wasm_config_delete*(a1: ptr wasm_config_t) {.cdecl,
    importc: "wasm_config_delete", dynlib: wasmer.}
proc wasm_config_new*(): ptr wasm_config_t {.cdecl, importc: "wasm_config_new",
    dynlib: wasmer.}

proc wasm_engine_delete*(a1: ptr wasm_engine_t) {.cdecl,
    importc: "wasm_engine_delete", dynlib: wasmer.}
proc wasm_engine_new*(): ptr wasm_engine_t {.cdecl, importc: "wasm_engine_new",
    dynlib: wasmer.}
proc wasm_engine_new_with_config*(a1: ptr wasm_config_t): ptr wasm_engine_t {.cdecl,
    importc: "wasm_engine_new_with_config", dynlib: wasmer.}

proc wasm_store_delete*(a1: ptr wasm_store_t) {.cdecl, importc: "wasm_store_delete",
    dynlib: wasmer.}
proc wasm_store_new*(a1: ptr wasm_engine_t): ptr wasm_store_t {.cdecl,
    importc: "wasm_store_new", dynlib: wasmer.}
type
  wasm_mutability_enum* {.size: sizeof(uint8).} = enum
    WASM_CONST, WASM_VAR


type
  wasm_limits_t* {.bycopy.} = object
    min*: uint32
    max*: uint32


#var wasm_limits_max_default* {.importc: "wasm_limits_max_default", dynlib: wasmer.}: uint32


proc wasm_valtype_delete*(a1: ptr wasm_valtype_t) {.cdecl,
    importc: "wasm_valtype_delete", dynlib: wasmer.}
type
  wasm_valtype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_valtype_t]


proc wasm_valtype_vec_new_empty*(`out`: ptr wasm_valtype_vec_t) {.cdecl,
    importc: "wasm_valtype_vec_new_empty", dynlib: wasmer.}
proc wasm_valtype_vec_new_uninitialized*(`out`: ptr wasm_valtype_vec_t; a2: csize_t) {.
    cdecl, importc: "wasm_valtype_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_valtype_vec_new*(`out`: ptr wasm_valtype_vec_t; a2: csize_t;
                          a3: ptr ptr wasm_valtype_t) {.cdecl,
    importc: "wasm_valtype_vec_new", dynlib: wasmer.}
proc wasm_valtype_vec_copy*(`out`: ptr wasm_valtype_vec_t;
                           a2: ptr wasm_valtype_vec_t) {.cdecl,
    importc: "wasm_valtype_vec_copy", dynlib: wasmer.}
proc wasm_valtype_vec_delete*(a1: ptr wasm_valtype_vec_t) {.cdecl,
    importc: "wasm_valtype_vec_delete", dynlib: wasmer.}
proc wasm_valtype_copy*(a1: ptr wasm_valtype_t): ptr wasm_valtype_t {.cdecl,
    importc: "wasm_valtype_copy", dynlib: wasmer.}
type
  wasm_valkind_enum* {.size: sizeof(uint8).} = enum
    WASM_I32, WASM_I64, WASM_F32, WASM_F64, WASM_ANYREF = 128, WASM_FUNCREF


proc wasm_valtype_new*(a1: wasm_valkind_enum): ptr wasm_valtype_t {.cdecl,
    importc: "wasm_valtype_new", dynlib: wasmer.}
proc wasm_valtype_kind*(a1: ptr wasm_valtype_t): wasm_valkind_enum {.cdecl,
    importc: "wasm_valtype_kind", dynlib: wasmer.}
## !!!Ignored construct:  static inline # ./wasm.h 3 4 [NewLine] _Bool # ./wasm.h [NewLine] wasm_valkind_is_num ( wasm_valkind_enum k ) { return k < WASM_ANYREF ; } static inline # ./wasm.h 3 4 [NewLine] _Bool # ./wasm.h [NewLine] wasm_valkind_is_ref ( wasm_valkind_t k ) { return k >= WASM_ANYREF ; } static inline # ./wasm.h 3 4 [NewLine] _Bool # ./wasm.h [NewLine] wasm_valtype_is_num ( const wasm_valtype_t * t ) { return wasm_valkind_is_num ( wasm_valtype_kind ( t ) ) ; } static inline # ./wasm.h 3 4 [NewLine] _Bool # ./wasm.h [NewLine] wasm_valtype_is_ref ( const wasm_valtype_t * t ) { return wasm_valkind_is_ref ( wasm_valtype_kind ( t ) ) ; } typedef struct wasm_functype_t wasm_functype_t ;
## Error: identifier expected, but got: #!!!

proc wasm_functype_delete*(a1: ptr wasm_functype_t) {.cdecl,
    importc: "wasm_functype_delete", dynlib: wasmer.}
type
  wasm_functype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_functype_t]


proc wasm_functype_vec_new_empty*(`out`: ptr wasm_functype_vec_t) {.cdecl,
    importc: "wasm_functype_vec_new_empty", dynlib: wasmer.}
proc wasm_functype_vec_new_uninitialized*(`out`: ptr wasm_functype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_functype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_functype_vec_new*(`out`: ptr wasm_functype_vec_t; a2: csize_t;
                           a3: ptr ptr wasm_functype_t) {.cdecl,
    importc: "wasm_functype_vec_new", dynlib: wasmer.}
proc wasm_functype_vec_copy*(`out`: ptr wasm_functype_vec_t;
                            a2: ptr wasm_functype_vec_t) {.cdecl,
    importc: "wasm_functype_vec_copy", dynlib: wasmer.}
proc wasm_functype_vec_delete*(a1: ptr wasm_functype_vec_t) {.cdecl,
    importc: "wasm_functype_vec_delete", dynlib: wasmer.}
proc wasm_functype_copy*(a1: ptr wasm_functype_t): ptr wasm_functype_t {.cdecl,
    importc: "wasm_functype_copy", dynlib: wasmer.}
proc wasm_functype_new*(params: ptr wasm_valtype_vec_t;
                       results: ptr wasm_valtype_vec_t): ptr wasm_functype_t {.cdecl,
    importc: "wasm_functype_new", dynlib: wasmer.}
proc wasm_functype_params*(a1: ptr wasm_functype_t): ptr wasm_valtype_vec_t {.cdecl,
    importc: "wasm_functype_params", dynlib: wasmer.}
proc wasm_functype_results*(a1: ptr wasm_functype_t): ptr wasm_valtype_vec_t {.cdecl,
    importc: "wasm_functype_results", dynlib: wasmer.}

proc wasm_globaltype_delete*(a1: ptr wasm_globaltype_t) {.cdecl,
    importc: "wasm_globaltype_delete", dynlib: wasmer.}
type
  wasm_globaltype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_globaltype_t]


proc wasm_globaltype_vec_new_empty*(`out`: ptr wasm_globaltype_vec_t) {.cdecl,
    importc: "wasm_globaltype_vec_new_empty", dynlib: wasmer.}
proc wasm_globaltype_vec_new_uninitialized*(`out`: ptr wasm_globaltype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_globaltype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_globaltype_vec_new*(`out`: ptr wasm_globaltype_vec_t; a2: csize_t;
                             a3: ptr ptr wasm_globaltype_t) {.cdecl,
    importc: "wasm_globaltype_vec_new", dynlib: wasmer.}
proc wasm_globaltype_vec_copy*(`out`: ptr wasm_globaltype_vec_t;
                              a2: ptr wasm_globaltype_vec_t) {.cdecl,
    importc: "wasm_globaltype_vec_copy", dynlib: wasmer.}
proc wasm_globaltype_vec_delete*(a1: ptr wasm_globaltype_vec_t) {.cdecl,
    importc: "wasm_globaltype_vec_delete", dynlib: wasmer.}
proc wasm_globaltype_copy*(a1: ptr wasm_globaltype_t): ptr wasm_globaltype_t {.cdecl,
    importc: "wasm_globaltype_copy", dynlib: wasmer.}
proc wasm_globaltype_new*(a1: ptr wasm_valtype_t; a2: wasm_mutability_enum): ptr wasm_globaltype_t {.
    cdecl, importc: "wasm_globaltype_new", dynlib: wasmer.}
proc wasm_globaltype_content*(a1: ptr wasm_globaltype_t): ptr wasm_valtype_t {.cdecl,
    importc: "wasm_globaltype_content", dynlib: wasmer.}
proc wasm_globaltype_mutability*(a1: ptr wasm_globaltype_t): wasm_mutability_enum {.
    cdecl, importc: "wasm_globaltype_mutability", dynlib: wasmer.}

proc wasm_tabletype_delete*(a1: ptr wasm_tabletype_t) {.cdecl,
    importc: "wasm_tabletype_delete", dynlib: wasmer.}
type
  wasm_tabletype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_tabletype_t]


proc wasm_tabletype_vec_new_empty*(`out`: ptr wasm_tabletype_vec_t) {.cdecl,
    importc: "wasm_tabletype_vec_new_empty", dynlib: wasmer.}
proc wasm_tabletype_vec_new_uninitialized*(`out`: ptr wasm_tabletype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_tabletype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_tabletype_vec_new*(`out`: ptr wasm_tabletype_vec_t; a2: csize_t;
                            a3: ptr ptr wasm_tabletype_t) {.cdecl,
    importc: "wasm_tabletype_vec_new", dynlib: wasmer.}
proc wasm_tabletype_vec_copy*(`out`: ptr wasm_tabletype_vec_t;
                             a2: ptr wasm_tabletype_vec_t) {.cdecl,
    importc: "wasm_tabletype_vec_copy", dynlib: wasmer.}
proc wasm_tabletype_vec_delete*(a1: ptr wasm_tabletype_vec_t) {.cdecl,
    importc: "wasm_tabletype_vec_delete", dynlib: wasmer.}
proc wasm_tabletype_copy*(a1: ptr wasm_tabletype_t): ptr wasm_tabletype_t {.cdecl,
    importc: "wasm_tabletype_copy", dynlib: wasmer.}
proc wasm_tabletype_new*(a1: ptr wasm_valtype_t; a2: ptr wasm_limits_t): ptr wasm_tabletype_t {.
    cdecl, importc: "wasm_tabletype_new", dynlib: wasmer.}
proc wasm_tabletype_element*(a1: ptr wasm_tabletype_t): ptr wasm_valtype_t {.cdecl,
    importc: "wasm_tabletype_element", dynlib: wasmer.}
proc wasm_tabletype_limits*(a1: ptr wasm_tabletype_t): ptr wasm_limits_t {.cdecl,
    importc: "wasm_tabletype_limits", dynlib: wasmer.}

proc wasm_memorytype_delete*(a1: ptr wasm_memorytype_t) {.cdecl,
    importc: "wasm_memorytype_delete", dynlib: wasmer.}
type
  wasm_memorytype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_memorytype_t]


proc wasm_memorytype_vec_new_empty*(`out`: ptr wasm_memorytype_vec_t) {.cdecl,
    importc: "wasm_memorytype_vec_new_empty", dynlib: wasmer.}
proc wasm_memorytype_vec_new_uninitialized*(`out`: ptr wasm_memorytype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_memorytype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_memorytype_vec_new*(`out`: ptr wasm_memorytype_vec_t; a2: csize_t;
                             a3: ptr ptr wasm_memorytype_t) {.cdecl,
    importc: "wasm_memorytype_vec_new", dynlib: wasmer.}
proc wasm_memorytype_vec_copy*(`out`: ptr wasm_memorytype_vec_t;
                              a2: ptr wasm_memorytype_vec_t) {.cdecl,
    importc: "wasm_memorytype_vec_copy", dynlib: wasmer.}
proc wasm_memorytype_vec_delete*(a1: ptr wasm_memorytype_vec_t) {.cdecl,
    importc: "wasm_memorytype_vec_delete", dynlib: wasmer.}
proc wasm_memorytype_copy*(a1: ptr wasm_memorytype_t): ptr wasm_memorytype_t {.cdecl,
    importc: "wasm_memorytype_copy", dynlib: wasmer.}
proc wasm_memorytype_new*(a1: ptr wasm_limits_t): ptr wasm_memorytype_t {.cdecl,
    importc: "wasm_memorytype_new", dynlib: wasmer.}
proc wasm_memorytype_limits*(a1: ptr wasm_memorytype_t): ptr wasm_limits_t {.cdecl,
    importc: "wasm_memorytype_limits", dynlib: wasmer.}

proc wasm_externtype_delete*(a1: ptr wasm_externtype_t) {.cdecl,
    importc: "wasm_externtype_delete", dynlib: wasmer.}
type
  wasm_externtype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_externtype_t]


proc wasm_externtype_vec_new_empty*(`out`: ptr wasm_externtype_vec_t) {.cdecl,
    importc: "wasm_externtype_vec_new_empty", dynlib: wasmer.}
proc wasm_externtype_vec_new_uninitialized*(`out`: ptr wasm_externtype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_externtype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_externtype_vec_new*(`out`: ptr wasm_externtype_vec_t; a2: csize_t;
                             a3: ptr ptr wasm_externtype_t) {.cdecl,
    importc: "wasm_externtype_vec_new", dynlib: wasmer.}
proc wasm_externtype_vec_copy*(`out`: ptr wasm_externtype_vec_t;
                              a2: ptr wasm_externtype_vec_t) {.cdecl,
    importc: "wasm_externtype_vec_copy", dynlib: wasmer.}
proc wasm_externtype_vec_delete*(a1: ptr wasm_externtype_vec_t) {.cdecl,
    importc: "wasm_externtype_vec_delete", dynlib: wasmer.}
proc wasm_externtype_copy*(a1: ptr wasm_externtype_t): ptr wasm_externtype_t {.cdecl,
    importc: "wasm_externtype_copy", dynlib: wasmer.}
type
  wasm_externkind_enum* {.size: sizeof(uint8).} = enum
    WASM_EXTERN_FUNC, WASM_EXTERN_GLOBAL, WASM_EXTERN_TABLE, WASM_EXTERN_MEMORY


proc wasm_externtype_kind*(a1: ptr wasm_externtype_t): wasm_externkind_enum {.cdecl,
    importc: "wasm_externtype_kind", dynlib: wasmer.}
proc wasm_functype_as_externtype*(a1: ptr wasm_functype_t): ptr wasm_externtype_t {.
    cdecl, importc: "wasm_functype_as_externtype", dynlib: wasmer.}
proc wasm_globaltype_as_externtype*(a1: ptr wasm_globaltype_t): ptr wasm_externtype_t {.
    cdecl, importc: "wasm_globaltype_as_externtype", dynlib: wasmer.}
proc wasm_tabletype_as_externtype*(a1: ptr wasm_tabletype_t): ptr wasm_externtype_t {.
    cdecl, importc: "wasm_tabletype_as_externtype", dynlib: wasmer.}
proc wasm_memorytype_as_externtype*(a1: ptr wasm_memorytype_t): ptr wasm_externtype_t {.
    cdecl, importc: "wasm_memorytype_as_externtype", dynlib: wasmer.}
proc wasm_externtype_as_functype*(a1: ptr wasm_externtype_t): ptr wasm_functype_t {.
    cdecl, importc: "wasm_externtype_as_functype", dynlib: wasmer.}
proc wasm_externtype_as_globaltype*(a1: ptr wasm_externtype_t): ptr wasm_globaltype_t {.
    cdecl, importc: "wasm_externtype_as_globaltype", dynlib: wasmer.}
proc wasm_externtype_as_tabletype*(a1: ptr wasm_externtype_t): ptr wasm_tabletype_t {.
    cdecl, importc: "wasm_externtype_as_tabletype", dynlib: wasmer.}
proc wasm_externtype_as_memorytype*(a1: ptr wasm_externtype_t): ptr wasm_memorytype_t {.
    cdecl, importc: "wasm_externtype_as_memorytype", dynlib: wasmer.}
proc wasm_functype_as_externtype_const*(a1: ptr wasm_functype_t): ptr wasm_externtype_t {.
    cdecl, importc: "wasm_functype_as_externtype_const", dynlib: wasmer.}
proc wasm_globaltype_as_externtype_const*(a1: ptr wasm_globaltype_t): ptr wasm_externtype_t {.
    cdecl, importc: "wasm_globaltype_as_externtype_const", dynlib: wasmer.}
proc wasm_tabletype_as_externtype_const*(a1: ptr wasm_tabletype_t): ptr wasm_externtype_t {.
    cdecl, importc: "wasm_tabletype_as_externtype_const", dynlib: wasmer.}
proc wasm_memorytype_as_externtype_const*(a1: ptr wasm_memorytype_t): ptr wasm_externtype_t {.
    cdecl, importc: "wasm_memorytype_as_externtype_const", dynlib: wasmer.}
proc wasm_externtype_as_functype_const*(a1: ptr wasm_externtype_t): ptr wasm_functype_t {.
    cdecl, importc: "wasm_externtype_as_functype_const", dynlib: wasmer.}
proc wasm_externtype_as_globaltype_const*(a1: ptr wasm_externtype_t): ptr wasm_globaltype_t {.
    cdecl, importc: "wasm_externtype_as_globaltype_const", dynlib: wasmer.}
proc wasm_externtype_as_tabletype_const*(a1: ptr wasm_externtype_t): ptr wasm_tabletype_t {.
    cdecl, importc: "wasm_externtype_as_tabletype_const", dynlib: wasmer.}
proc wasm_externtype_as_memorytype_const*(a1: ptr wasm_externtype_t): ptr wasm_memorytype_t {.
    cdecl, importc: "wasm_externtype_as_memorytype_const", dynlib: wasmer.}

proc wasm_importtype_delete*(a1: ptr wasm_importtype_t) {.cdecl,
    importc: "wasm_importtype_delete", dynlib: wasmer.}
type
  wasm_importtype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_importtype_t]


proc wasm_importtype_vec_new_empty*(`out`: ptr wasm_importtype_vec_t) {.cdecl,
    importc: "wasm_importtype_vec_new_empty", dynlib: wasmer.}
proc wasm_importtype_vec_new_uninitialized*(`out`: ptr wasm_importtype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_importtype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_importtype_vec_new*(`out`: ptr wasm_importtype_vec_t; a2: csize_t;
                             a3: ptr ptr wasm_importtype_t) {.cdecl,
    importc: "wasm_importtype_vec_new", dynlib: wasmer.}
proc wasm_importtype_vec_copy*(`out`: ptr wasm_importtype_vec_t;
                              a2: ptr wasm_importtype_vec_t) {.cdecl,
    importc: "wasm_importtype_vec_copy", dynlib: wasmer.}
proc wasm_importtype_vec_delete*(a1: ptr wasm_importtype_vec_t) {.cdecl,
    importc: "wasm_importtype_vec_delete", dynlib: wasmer.}
proc wasm_importtype_copy*(a1: ptr wasm_importtype_t): ptr wasm_importtype_t {.cdecl,
    importc: "wasm_importtype_copy", dynlib: wasmer.}
proc wasm_importtype_new*(module: ptr wasm_name_t; name: ptr wasm_name_t;
                         a3: ptr wasm_externtype_t): ptr wasm_importtype_t {.cdecl,
    importc: "wasm_importtype_new", dynlib: wasmer.}
proc wasm_importtype_module*(a1: ptr wasm_importtype_t): ptr wasm_name_t {.cdecl,
    importc: "wasm_importtype_module", dynlib: wasmer.}
proc wasm_importtype_name*(a1: ptr wasm_importtype_t): ptr wasm_name_t {.cdecl,
    importc: "wasm_importtype_name", dynlib: wasmer.}
proc wasm_importtype_type*(a1: ptr wasm_importtype_t): ptr wasm_externtype_t {.cdecl,
    importc: "wasm_importtype_type", dynlib: wasmer.}

proc wasm_exporttype_delete*(a1: ptr wasm_exporttype_t) {.cdecl,
    importc: "wasm_exporttype_delete", dynlib: wasmer.}
type
  wasm_exporttype_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_exporttype_t]


proc wasm_exporttype_vec_new_empty*(`out`: ptr wasm_exporttype_vec_t) {.cdecl,
    importc: "wasm_exporttype_vec_new_empty", dynlib: wasmer.}
proc wasm_exporttype_vec_new_uninitialized*(`out`: ptr wasm_exporttype_vec_t;
    a2: csize_t) {.cdecl, importc: "wasm_exporttype_vec_new_uninitialized",
                 dynlib: wasmer.}
proc wasm_exporttype_vec_new*(`out`: ptr wasm_exporttype_vec_t; a2: csize_t;
                             a3: ptr ptr wasm_exporttype_t) {.cdecl,
    importc: "wasm_exporttype_vec_new", dynlib: wasmer.}
proc wasm_exporttype_vec_copy*(`out`: ptr wasm_exporttype_vec_t;
                              a2: ptr wasm_exporttype_vec_t) {.cdecl,
    importc: "wasm_exporttype_vec_copy", dynlib: wasmer.}
proc wasm_exporttype_vec_delete*(a1: ptr wasm_exporttype_vec_t) {.cdecl,
    importc: "wasm_exporttype_vec_delete", dynlib: wasmer.}
proc wasm_exporttype_copy*(a1: ptr wasm_exporttype_t): ptr wasm_exporttype_t {.cdecl,
    importc: "wasm_exporttype_copy", dynlib: wasmer.}
proc wasm_exporttype_new*(a1: ptr wasm_name_t; a2: ptr wasm_externtype_t): ptr wasm_exporttype_t {.
    cdecl, importc: "wasm_exporttype_new", dynlib: wasmer.}
proc wasm_exporttype_name*(a1: ptr wasm_exporttype_t): ptr wasm_name_t {.cdecl,
    importc: "wasm_exporttype_name", dynlib: wasmer.}
proc wasm_exporttype_type*(a1: ptr wasm_exporttype_t): ptr wasm_externtype_t {.cdecl,
    importc: "wasm_exporttype_type", dynlib: wasmer.}
discard "forward decl of wasm_ref_t"
type
  INNER_C_UNION_expanded_826* {.bycopy, union.} = object
    i32*: int32
    i64*: int64
    f32*: float32
    f64*: float64
    `ref`*: ptr wasm_ref_t

  wasm_val_t* {.bycopy.} = object
    case kind*: wasm_valkind_enum
    of WasmI32:
      i32*: int32
    of WasmI64:
      i64*: int64
    of WasmF32:
      f32*: float32
    of WasmF64:
      f64*: float64
    else:
      theRef*: ptr wasm_ref_t


proc wasm_val_delete*(v: ptr wasm_val_t) {.cdecl, importc: "wasm_val_delete",
                                       dynlib: wasmer.}
proc wasm_val_copy*(`out`: ptr wasm_val_t; a2: ptr wasm_val_t) {.cdecl,
    importc: "wasm_val_copy", dynlib: wasmer.}
type
  wasm_val_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[wasm_val_t]


proc wasm_val_vec_new_empty*(`out`: ptr wasm_val_vec_t) {.cdecl,
    importc: "wasm_val_vec_new_empty", dynlib: wasmer.}
proc wasm_val_vec_new_uninitialized*(`out`: ptr wasm_val_vec_t; a2: csize_t) {.cdecl,
    importc: "wasm_val_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_val_vec_new*(`out`: ptr wasm_val_vec_t; a2: csize_t; a3: ptr wasm_val_t) {.
    cdecl, importc: "wasm_val_vec_new", dynlib: wasmer.}
proc wasm_val_vec_copy*(`out`: ptr wasm_val_vec_t; a2: ptr wasm_val_vec_t) {.cdecl,
    importc: "wasm_val_vec_copy", dynlib: wasmer.}
proc wasm_val_vec_delete*(a1: ptr wasm_val_vec_t) {.cdecl,
    importc: "wasm_val_vec_delete", dynlib: wasmer.}

proc wasm_ref_delete*(a1: ptr wasm_ref_t) {.cdecl, importc: "wasm_ref_delete",
                                        dynlib: wasmer.}
proc wasm_ref_copy*(a1: ptr wasm_ref_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_ref_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_ref_same ( const wasm_ref_t * , const wasm_ref_t * ) ;
## Error: expected ';'!!!

proc wasm_ref_get_host_info*(a1: ptr wasm_ref_t): pointer {.cdecl,
    importc: "wasm_ref_get_host_info", dynlib: wasmer.}
proc wasm_ref_set_host_info*(a1: ptr wasm_ref_t; a2: pointer) {.cdecl,
    importc: "wasm_ref_set_host_info", dynlib: wasmer.}
proc wasm_ref_set_host_info_with_finalizer*(a1: ptr wasm_ref_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_ref_set_host_info_with_finalizer",
                                   dynlib: wasmer.}

proc wasm_frame_delete*(a1: ptr wasm_frame_t) {.cdecl, importc: "wasm_frame_delete",
    dynlib: wasmer.}
type
  wasm_frame_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_frame_t]


proc wasm_frame_vec_new_empty*(`out`: ptr wasm_frame_vec_t) {.cdecl,
    importc: "wasm_frame_vec_new_empty", dynlib: wasmer.}
proc wasm_frame_vec_new_uninitialized*(`out`: ptr wasm_frame_vec_t; a2: csize_t) {.
    cdecl, importc: "wasm_frame_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_frame_vec_new*(`out`: ptr wasm_frame_vec_t; a2: csize_t;
                        a3: ptr ptr wasm_frame_t) {.cdecl,
    importc: "wasm_frame_vec_new", dynlib: wasmer.}
proc wasm_frame_vec_copy*(`out`: ptr wasm_frame_vec_t; a2: ptr wasm_frame_vec_t) {.
    cdecl, importc: "wasm_frame_vec_copy", dynlib: wasmer.}
proc wasm_frame_vec_delete*(a1: ptr wasm_frame_vec_t) {.cdecl,
    importc: "wasm_frame_vec_delete", dynlib: wasmer.}
proc wasm_frame_copy*(a1: ptr wasm_frame_t): ptr wasm_frame_t {.cdecl,
    importc: "wasm_frame_copy", dynlib: wasmer.}
proc wasm_frame_instance*(a1: ptr wasm_frame_t): ptr wasm_instance_t {.cdecl,
    importc: "wasm_frame_instance", dynlib: wasmer.}
proc wasm_frame_func_index*(a1: ptr wasm_frame_t): uint32 {.cdecl,
    importc: "wasm_frame_func_index", dynlib: wasmer.}
proc wasm_frame_func_offset*(a1: ptr wasm_frame_t): csize_t {.cdecl,
    importc: "wasm_frame_func_offset", dynlib: wasmer.}
proc wasm_frame_module_offset*(a1: ptr wasm_frame_t): csize_t {.cdecl,
    importc: "wasm_frame_module_offset", dynlib: wasmer.}
type
  wasm_message_t* = wasm_name_t

proc wasm_trap_delete*(a1: ptr wasm_trap_t) {.cdecl, importc: "wasm_trap_delete",
    dynlib: wasmer.}
proc wasm_trap_copy*(a1: ptr wasm_trap_t): ptr wasm_trap_t {.cdecl,
    importc: "wasm_trap_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_trap_same ( const wasm_trap_t * , const wasm_trap_t * ) ;
## Error: expected ';'!!!

proc wasm_trap_get_host_info*(a1: ptr wasm_trap_t): pointer {.cdecl,
    importc: "wasm_trap_get_host_info", dynlib: wasmer.}
proc wasm_trap_set_host_info*(a1: ptr wasm_trap_t; a2: pointer) {.cdecl,
    importc: "wasm_trap_set_host_info", dynlib: wasmer.}
proc wasm_trap_set_host_info_with_finalizer*(a1: ptr wasm_trap_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_trap_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_trap_as_ref*(a1: ptr wasm_trap_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_trap_as_ref", dynlib: wasmer.}
proc wasm_ref_as_trap*(a1: ptr wasm_ref_t): ptr wasm_trap_t {.cdecl,
    importc: "wasm_ref_as_trap", dynlib: wasmer.}
proc wasm_trap_as_ref_const*(a1: ptr wasm_trap_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_trap_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_trap_const*(a1: ptr wasm_ref_t): ptr wasm_trap_t {.cdecl,
    importc: "wasm_ref_as_trap_const", dynlib: wasmer.}
proc wasm_trap_new*(store: ptr wasm_store_t; a2: ptr wasm_message_t): ptr wasm_trap_t {.
    cdecl, importc: "wasm_trap_new", dynlib: wasmer.}
proc wasm_trap_message*(a1: ptr wasm_trap_t; `out`: ptr wasm_message_t) {.cdecl,
    importc: "wasm_trap_message", dynlib: wasmer.}
proc wasm_trap_origin*(a1: ptr wasm_trap_t): ptr wasm_frame_t {.cdecl,
    importc: "wasm_trap_origin", dynlib: wasmer.}
proc wasm_trap_trace*(a1: ptr wasm_trap_t; `out`: ptr wasm_frame_vec_t) {.cdecl,
    importc: "wasm_trap_trace", dynlib: wasmer.}

proc wasm_foreign_delete*(a1: ptr wasm_foreign_t) {.cdecl,
    importc: "wasm_foreign_delete", dynlib: wasmer.}
proc wasm_foreign_copy*(a1: ptr wasm_foreign_t): ptr wasm_foreign_t {.cdecl,
    importc: "wasm_foreign_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_foreign_same ( const wasm_foreign_t * , const wasm_foreign_t * ) ;
## Error: expected ';'!!!

proc wasm_foreign_get_host_info*(a1: ptr wasm_foreign_t): pointer {.cdecl,
    importc: "wasm_foreign_get_host_info", dynlib: wasmer.}
proc wasm_foreign_set_host_info*(a1: ptr wasm_foreign_t; a2: pointer) {.cdecl,
    importc: "wasm_foreign_set_host_info", dynlib: wasmer.}
proc wasm_foreign_set_host_info_with_finalizer*(a1: ptr wasm_foreign_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_foreign_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_foreign_as_ref*(a1: ptr wasm_foreign_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_foreign_as_ref", dynlib: wasmer.}
proc wasm_ref_as_foreign*(a1: ptr wasm_ref_t): ptr wasm_foreign_t {.cdecl,
    importc: "wasm_ref_as_foreign", dynlib: wasmer.}
proc wasm_foreign_as_ref_const*(a1: ptr wasm_foreign_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_foreign_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_foreign_const*(a1: ptr wasm_ref_t): ptr wasm_foreign_t {.cdecl,
    importc: "wasm_ref_as_foreign_const", dynlib: wasmer.}
proc wasm_foreign_new*(a1: ptr wasm_store_t): ptr wasm_foreign_t {.cdecl,
    importc: "wasm_foreign_new", dynlib: wasmer.}

proc wasm_module_delete*(a1: ptr wasm_module_t) {.cdecl,
    importc: "wasm_module_delete", dynlib: wasmer.}
proc wasm_module_copy*(a1: ptr wasm_module_t): ptr wasm_module_t {.cdecl,
    importc: "wasm_module_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_module_same ( const wasm_module_t * , const wasm_module_t * ) ;
## Error: expected ';'!!!

proc wasm_module_get_host_info*(a1: ptr wasm_module_t): pointer {.cdecl,
    importc: "wasm_module_get_host_info", dynlib: wasmer.}
proc wasm_module_set_host_info*(a1: ptr wasm_module_t; a2: pointer) {.cdecl,
    importc: "wasm_module_set_host_info", dynlib: wasmer.}
proc wasm_module_set_host_info_with_finalizer*(a1: ptr wasm_module_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_module_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_module_as_ref*(a1: ptr wasm_module_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_module_as_ref", dynlib: wasmer.}
proc wasm_ref_as_module*(a1: ptr wasm_ref_t): ptr wasm_module_t {.cdecl,
    importc: "wasm_ref_as_module", dynlib: wasmer.}
proc wasm_module_as_ref_const*(a1: ptr wasm_module_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_module_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_module_const*(a1: ptr wasm_ref_t): ptr wasm_module_t {.cdecl,
    importc: "wasm_ref_as_module_const", dynlib: wasmer.}

proc wasm_shared_module_delete*(a1: ptr wasm_shared_module_t) {.cdecl,
    importc: "wasm_shared_module_delete", dynlib: wasmer.}
proc wasm_module_share*(a1: ptr wasm_module_t): ptr wasm_shared_module_t {.cdecl,
    importc: "wasm_module_share", dynlib: wasmer.}
proc wasm_module_obtain*(a1: ptr wasm_store_t; a2: ptr wasm_shared_module_t): ptr wasm_module_t {.
    cdecl, importc: "wasm_module_obtain", dynlib: wasmer.}
proc wasm_module_new*(a1: ptr wasm_store_t; binary: ptr wasm_byte_vec_t): ptr wasm_module_t {.
    cdecl, importc: "wasm_module_new", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_module_validate ( wasm_store_t * , const wasm_byte_vec_t * binary ) ;
## Error: expected ';'!!!

proc wasm_module_imports*(a1: ptr wasm_module_t; `out`: ptr wasm_importtype_vec_t) {.
    cdecl, importc: "wasm_module_imports", dynlib: wasmer.}
proc wasm_module_exports*(a1: ptr wasm_module_t; `out`: ptr wasm_exporttype_vec_t) {.
    cdecl, importc: "wasm_module_exports", dynlib: wasmer.}
proc wasm_module_serialize*(a1: ptr wasm_module_t; `out`: ptr wasm_byte_vec_t) {.cdecl,
    importc: "wasm_module_serialize", dynlib: wasmer.}
proc wasm_module_deserialize*(a1: ptr wasm_store_t; a2: ptr wasm_byte_vec_t): ptr wasm_module_t {.
    cdecl, importc: "wasm_module_deserialize", dynlib: wasmer.}

proc wasm_func_delete*(a1: ptr wasm_func_t) {.cdecl, importc: "wasm_func_delete",
    dynlib: wasmer.}
proc wasm_func_copy*(a1: ptr wasm_func_t): ptr wasm_func_t {.cdecl,
    importc: "wasm_func_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_func_same ( const wasm_func_t * , const wasm_func_t * ) ;
## Error: expected ';'!!!

proc wasm_func_get_host_info*(a1: ptr wasm_func_t): pointer {.cdecl,
    importc: "wasm_func_get_host_info", dynlib: wasmer.}
proc wasm_func_set_host_info*(a1: ptr wasm_func_t; a2: pointer) {.cdecl,
    importc: "wasm_func_set_host_info", dynlib: wasmer.}
proc wasm_func_set_host_info_with_finalizer*(a1: ptr wasm_func_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_func_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_func_as_ref*(a1: ptr wasm_func_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_func_as_ref", dynlib: wasmer.}
proc wasm_ref_as_func*(a1: ptr wasm_ref_t): ptr wasm_func_t {.cdecl,
    importc: "wasm_ref_as_func", dynlib: wasmer.}
proc wasm_func_as_ref_const*(a1: ptr wasm_func_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_func_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_func_const*(a1: ptr wasm_ref_t): ptr wasm_func_t {.cdecl,
    importc: "wasm_ref_as_func_const", dynlib: wasmer.}
type
  wasm_func_callback_t* = proc (args: ptr wasm_val_vec_t; results: ptr wasm_val_vec_t): ptr wasm_trap_t {.
      cdecl.}
  wasm_func_callback_with_env_t* = proc (env: pointer; args: ptr wasm_val_vec_t;
                                      results: ptr wasm_val_vec_t): ptr wasm_trap_t {.
      cdecl.}

proc wasm_func_new*(a1: ptr wasm_store_t; a2: ptr wasm_functype_t;
                   a3: wasm_func_callback_t): ptr wasm_func_t {.cdecl,
    importc: "wasm_func_new", dynlib: wasmer.}
proc wasm_func_new_with_env*(a1: ptr wasm_store_t; `type`: ptr wasm_functype_t;
                            a3: wasm_func_callback_with_env_t; env: pointer;
                            finalizer: proc (a1: pointer) {.cdecl.}): ptr wasm_func_t {.
    cdecl, importc: "wasm_func_new_with_env", dynlib: wasmer.}
proc wasm_func_type*(a1: ptr wasm_func_t): ptr wasm_functype_t {.cdecl,
    importc: "wasm_func_type", dynlib: wasmer.}
proc wasm_func_param_arity*(a1: ptr wasm_func_t): csize_t {.cdecl,
    importc: "wasm_func_param_arity", dynlib: wasmer.}
proc wasm_func_result_arity*(a1: ptr wasm_func_t): csize_t {.cdecl,
    importc: "wasm_func_result_arity", dynlib: wasmer.}
proc wasm_func_call*(a1: ptr wasm_func_t; args: ptr wasm_val_vec_t;
                    results: ptr wasm_val_vec_t): ptr wasm_trap_t {.cdecl,
    importc: "wasm_func_call", dynlib: wasmer.}

proc wasm_global_delete*(a1: ptr wasm_global_t) {.cdecl,
    importc: "wasm_global_delete", dynlib: wasmer.}
proc wasm_global_copy*(a1: ptr wasm_global_t): ptr wasm_global_t {.cdecl,
    importc: "wasm_global_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_global_same ( const wasm_global_t * , const wasm_global_t * ) ;
## Error: expected ';'!!!

proc wasm_global_get_host_info*(a1: ptr wasm_global_t): pointer {.cdecl,
    importc: "wasm_global_get_host_info", dynlib: wasmer.}
proc wasm_global_set_host_info*(a1: ptr wasm_global_t; a2: pointer) {.cdecl,
    importc: "wasm_global_set_host_info", dynlib: wasmer.}
proc wasm_global_set_host_info_with_finalizer*(a1: ptr wasm_global_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_global_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_global_as_ref*(a1: ptr wasm_global_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_global_as_ref", dynlib: wasmer.}
proc wasm_ref_as_global*(a1: ptr wasm_ref_t): ptr wasm_global_t {.cdecl,
    importc: "wasm_ref_as_global", dynlib: wasmer.}
proc wasm_global_as_ref_const*(a1: ptr wasm_global_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_global_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_global_const*(a1: ptr wasm_ref_t): ptr wasm_global_t {.cdecl,
    importc: "wasm_ref_as_global_const", dynlib: wasmer.}
proc wasm_global_new*(a1: ptr wasm_store_t; a2: ptr wasm_globaltype_t;
                     a3: ptr wasm_val_t): ptr wasm_global_t {.cdecl,
    importc: "wasm_global_new", dynlib: wasmer.}
proc wasm_global_type*(a1: ptr wasm_global_t): ptr wasm_globaltype_t {.cdecl,
    importc: "wasm_global_type", dynlib: wasmer.}
proc wasm_global_get*(a1: ptr wasm_global_t; `out`: ptr wasm_val_t) {.cdecl,
    importc: "wasm_global_get", dynlib: wasmer.}
proc wasm_global_set*(a1: ptr wasm_global_t; a2: ptr wasm_val_t) {.cdecl,
    importc: "wasm_global_set", dynlib: wasmer.}

proc wasm_table_delete*(a1: ptr wasm_table_t) {.cdecl, importc: "wasm_table_delete",
    dynlib: wasmer.}
proc wasm_table_copy*(a1: ptr wasm_table_t): ptr wasm_table_t {.cdecl,
    importc: "wasm_table_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_table_same ( const wasm_table_t * , const wasm_table_t * ) ;
## Error: expected ';'!!!

proc wasm_table_get_host_info*(a1: ptr wasm_table_t): pointer {.cdecl,
    importc: "wasm_table_get_host_info", dynlib: wasmer.}
proc wasm_table_set_host_info*(a1: ptr wasm_table_t; a2: pointer) {.cdecl,
    importc: "wasm_table_set_host_info", dynlib: wasmer.}
proc wasm_table_set_host_info_with_finalizer*(a1: ptr wasm_table_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_table_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_table_as_ref*(a1: ptr wasm_table_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_table_as_ref", dynlib: wasmer.}
proc wasm_ref_as_table*(a1: ptr wasm_ref_t): ptr wasm_table_t {.cdecl,
    importc: "wasm_ref_as_table", dynlib: wasmer.}
proc wasm_table_as_ref_const*(a1: ptr wasm_table_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_table_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_table_const*(a1: ptr wasm_ref_t): ptr wasm_table_t {.cdecl,
    importc: "wasm_ref_as_table_const", dynlib: wasmer.}
type
  wasm_table_size_t* = uint32

proc wasm_table_new*(a1: ptr wasm_store_t; a2: ptr wasm_tabletype_t;
                    init: ptr wasm_ref_t): ptr wasm_table_t {.cdecl,
    importc: "wasm_table_new", dynlib: wasmer.}
proc wasm_table_type*(a1: ptr wasm_table_t): ptr wasm_tabletype_t {.cdecl,
    importc: "wasm_table_type", dynlib: wasmer.}
proc wasm_table_get*(a1: ptr wasm_table_t; index: wasm_table_size_t): ptr wasm_ref_t {.
    cdecl, importc: "wasm_table_get", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_table_set ( wasm_table_t * , wasm_table_size_t index , wasm_ref_t * ) ;
## Error: expected ';'!!!

proc wasm_table_size*(a1: ptr wasm_table_t): wasm_table_size_t {.cdecl,
    importc: "wasm_table_size", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_table_grow ( wasm_table_t * , wasm_table_size_t delta , wasm_ref_t * init ) ;
## Error: expected ';'!!!


proc wasm_memory_delete*(a1: ptr wasm_memory_t) {.cdecl,
    importc: "wasm_memory_delete", dynlib: wasmer.}
proc wasm_memory_copy*(a1: ptr wasm_memory_t): ptr wasm_memory_t {.cdecl,
    importc: "wasm_memory_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_memory_same ( const wasm_memory_t * , const wasm_memory_t * ) ;
## Error: expected ';'!!!

proc wasm_memory_get_host_info*(a1: ptr wasm_memory_t): pointer {.cdecl,
    importc: "wasm_memory_get_host_info", dynlib: wasmer.}
proc wasm_memory_set_host_info*(a1: ptr wasm_memory_t; a2: pointer) {.cdecl,
    importc: "wasm_memory_set_host_info", dynlib: wasmer.}
proc wasm_memory_set_host_info_with_finalizer*(a1: ptr wasm_memory_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_memory_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_memory_as_ref*(a1: ptr wasm_memory_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_memory_as_ref", dynlib: wasmer.}
proc wasm_ref_as_memory*(a1: ptr wasm_ref_t): ptr wasm_memory_t {.cdecl,
    importc: "wasm_ref_as_memory", dynlib: wasmer.}
proc wasm_memory_as_ref_const*(a1: ptr wasm_memory_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_memory_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_memory_const*(a1: ptr wasm_ref_t): ptr wasm_memory_t {.cdecl,
    importc: "wasm_ref_as_memory_const", dynlib: wasmer.}
type
  wasm_memory_pages_t* = uint32

#var MEMORY_PAGE_SIZE* {.importc: "MEMORY_PAGE_SIZE", dynlib: wasmer.}: csize_t

proc wasm_memory_new*(a1: ptr wasm_store_t; a2: ptr wasm_memorytype_t): ptr wasm_memory_t {.
    cdecl, importc: "wasm_memory_new", dynlib: wasmer.}
proc wasm_memory_type*(a1: ptr wasm_memory_t): ptr wasm_memorytype_t {.cdecl,
    importc: "wasm_memory_type", dynlib: wasmer.}
proc wasm_memory_data*(a1: ptr wasm_memory_t): ptr byte {.cdecl,
    importc: "wasm_memory_data", dynlib: wasmer.}
proc wasm_memory_data_size*(a1: ptr wasm_memory_t): csize_t {.cdecl,
    importc: "wasm_memory_data_size", dynlib: wasmer.}
proc wasm_memory_size*(a1: ptr wasm_memory_t): wasm_memory_pages_t {.cdecl,
    importc: "wasm_memory_size", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_memory_grow ( wasm_memory_t * , wasm_memory_pages_t delta ) ;
## Error: expected ';'!!!


proc wasm_extern_delete*(a1: ptr wasm_extern_t) {.cdecl,
    importc: "wasm_extern_delete", dynlib: wasmer.}
proc wasm_extern_copy*(a1: ptr wasm_extern_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_extern_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_extern_same ( const wasm_extern_t * , const wasm_extern_t * ) ;
## Error: expected ';'!!!

proc wasm_extern_get_host_info*(a1: ptr wasm_extern_t): pointer {.cdecl,
    importc: "wasm_extern_get_host_info", dynlib: wasmer.}
proc wasm_extern_set_host_info*(a1: ptr wasm_extern_t; a2: pointer) {.cdecl,
    importc: "wasm_extern_set_host_info", dynlib: wasmer.}
proc wasm_extern_set_host_info_with_finalizer*(a1: ptr wasm_extern_t; a2: pointer;
    a3: proc (a1: pointer) {.cdecl.}) {.cdecl, importc: "wasm_extern_set_host_info_with_finalizer",
                                   dynlib: wasmer.}
proc wasm_extern_as_ref*(a1: ptr wasm_extern_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_extern_as_ref", dynlib: wasmer.}
proc wasm_ref_as_extern*(a1: ptr wasm_ref_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_ref_as_extern", dynlib: wasmer.}
proc wasm_extern_as_ref_const*(a1: ptr wasm_extern_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_extern_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_extern_const*(a1: ptr wasm_ref_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_ref_as_extern_const", dynlib: wasmer.}
type
  wasm_extern_vec_t* {.bycopy.} = object
    size*: csize_t
    data*: ptr UncheckedArray[ptr wasm_extern_t]


proc wasm_extern_vec_new_empty*(`out`: ptr wasm_extern_vec_t) {.cdecl,
    importc: "wasm_extern_vec_new_empty", dynlib: wasmer.}
proc wasm_extern_vec_new_uninitialized*(`out`: ptr wasm_extern_vec_t; a2: csize_t) {.
    cdecl, importc: "wasm_extern_vec_new_uninitialized", dynlib: wasmer.}
proc wasm_extern_vec_new*(`out`: ptr wasm_extern_vec_t; a2: csize_t;
                         a3: ptr ptr wasm_extern_t) {.cdecl,
    importc: "wasm_extern_vec_new", dynlib: wasmer.}
proc wasm_extern_vec_copy*(`out`: ptr wasm_extern_vec_t; a2: ptr wasm_extern_vec_t) {.
    cdecl, importc: "wasm_extern_vec_copy", dynlib: wasmer.}
proc wasm_extern_vec_delete*(a1: ptr wasm_extern_vec_t) {.cdecl,
    importc: "wasm_extern_vec_delete", dynlib: wasmer.}
proc wasm_extern_kind*(a1: ptr wasm_extern_t): wasm_externkind_enum {.cdecl,
    importc: "wasm_extern_kind", dynlib: wasmer.}
proc wasm_extern_type*(a1: ptr wasm_extern_t): ptr wasm_externtype_t {.cdecl,
    importc: "wasm_extern_type", dynlib: wasmer.}
proc wasm_func_as_extern*(a1: ptr wasm_func_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_func_as_extern", dynlib: wasmer.}
proc wasm_global_as_extern*(a1: ptr wasm_global_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_global_as_extern", dynlib: wasmer.}
proc wasm_table_as_extern*(a1: ptr wasm_table_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_table_as_extern", dynlib: wasmer.}
proc wasm_memory_as_extern*(a1: ptr wasm_memory_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_memory_as_extern", dynlib: wasmer.}
proc wasm_extern_as_func*(a1: ptr wasm_extern_t): ptr wasm_func_t {.cdecl,
    importc: "wasm_extern_as_func", dynlib: wasmer.}
proc wasm_extern_as_global*(a1: ptr wasm_extern_t): ptr wasm_global_t {.cdecl,
    importc: "wasm_extern_as_global", dynlib: wasmer.}
proc wasm_extern_as_table*(a1: ptr wasm_extern_t): ptr wasm_table_t {.cdecl,
    importc: "wasm_extern_as_table", dynlib: wasmer.}
proc wasm_extern_as_memory*(a1: ptr wasm_extern_t): ptr wasm_memory_t {.cdecl,
    importc: "wasm_extern_as_memory", dynlib: wasmer.}
proc wasm_func_as_extern_const*(a1: ptr wasm_func_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_func_as_extern_const", dynlib: wasmer.}
proc wasm_global_as_extern_const*(a1: ptr wasm_global_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_global_as_extern_const", dynlib: wasmer.}
proc wasm_table_as_extern_const*(a1: ptr wasm_table_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_table_as_extern_const", dynlib: wasmer.}
proc wasm_memory_as_extern_const*(a1: ptr wasm_memory_t): ptr wasm_extern_t {.cdecl,
    importc: "wasm_memory_as_extern_const", dynlib: wasmer.}
proc wasm_extern_as_func_const*(a1: ptr wasm_extern_t): ptr wasm_func_t {.cdecl,
    importc: "wasm_extern_as_func_const", dynlib: wasmer.}
proc wasm_extern_as_global_const*(a1: ptr wasm_extern_t): ptr wasm_global_t {.cdecl,
    importc: "wasm_extern_as_global_const", dynlib: wasmer.}
proc wasm_extern_as_table_const*(a1: ptr wasm_extern_t): ptr wasm_table_t {.cdecl,
    importc: "wasm_extern_as_table_const", dynlib: wasmer.}
proc wasm_extern_as_memory_const*(a1: ptr wasm_extern_t): ptr wasm_memory_t {.cdecl,
    importc: "wasm_extern_as_memory_const", dynlib: wasmer.}

proc wasm_instance_delete*(a1: ptr wasm_instance_t) {.cdecl,
    importc: "wasm_instance_delete", dynlib: wasmer.}
proc wasm_instance_copy*(a1: ptr wasm_instance_t): ptr wasm_instance_t {.cdecl,
    importc: "wasm_instance_copy", dynlib: wasmer.}
## !!!Ignored construct:  _Bool # ./wasm.h [NewLine] wasm_instance_same ( const wasm_instance_t * , const wasm_instance_t * ) ;
## Error: expected ';'!!!

proc wasm_instance_get_host_info*(a1: ptr wasm_instance_t): pointer {.cdecl,
    importc: "wasm_instance_get_host_info", dynlib: wasmer.}
proc wasm_instance_set_host_info*(a1: ptr wasm_instance_t; a2: pointer) {.cdecl,
    importc: "wasm_instance_set_host_info", dynlib: wasmer.}
proc wasm_instance_set_host_info_with_finalizer*(a1: ptr wasm_instance_t;
    a2: pointer; a3: proc (a1: pointer) {.cdecl.}) {.cdecl,
    importc: "wasm_instance_set_host_info_with_finalizer", dynlib: wasmer.}
proc wasm_instance_as_ref*(a1: ptr wasm_instance_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_instance_as_ref", dynlib: wasmer.}
proc wasm_ref_as_instance*(a1: ptr wasm_ref_t): ptr wasm_instance_t {.cdecl,
    importc: "wasm_ref_as_instance", dynlib: wasmer.}
proc wasm_instance_as_ref_const*(a1: ptr wasm_instance_t): ptr wasm_ref_t {.cdecl,
    importc: "wasm_instance_as_ref_const", dynlib: wasmer.}
proc wasm_ref_as_instance_const*(a1: ptr wasm_ref_t): ptr wasm_instance_t {.cdecl,
    importc: "wasm_ref_as_instance_const", dynlib: wasmer.}
proc wasm_instance_new*(a1: ptr wasm_store_t; a2: ptr wasm_module_t;
                       imports: ptr wasm_extern_vec_t; a4: ptr ptr wasm_trap_t): ptr wasm_instance_t {.
    cdecl, importc: "wasm_instance_new", dynlib: wasmer.}
proc wasm_instance_exports*(a1: ptr wasm_instance_t; `out`: ptr wasm_extern_vec_t) {.
    cdecl, importc: "wasm_instance_exports", dynlib: wasmer.}
proc wasm_valtype_new_i32*(): ptr wasm_valtype_t {.inline, cdecl.} =
  return wasm_valtype_new(WASM_I32)

proc wasm_valtype_new_i64*(): ptr wasm_valtype_t {.inline, cdecl.} =
  return wasm_valtype_new(WASM_I64)

proc wasm_valtype_new_f32*(): ptr wasm_valtype_t {.inline, cdecl.} =
  return wasm_valtype_new(WASM_F32)

proc wasm_valtype_new_f64*(): ptr wasm_valtype_t {.inline, cdecl.} =
  return wasm_valtype_new(WASM_F64)

proc wasm_valtype_new_anyref*(): ptr wasm_valtype_t {.inline, cdecl.} =
  return wasm_valtype_new(WASM_ANYREF)

proc wasm_valtype_new_funcref*(): ptr wasm_valtype_t {.inline, cdecl.} =
  return wasm_valtype_new(WASM_FUNCREF)
#[
# These are silly with Nim, we have open arrays to do this automagically
proc wasm_functype_new_0_0*(): ptr wasm_functype_t {.inline, cdecl.} =
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new_empty(addr(params))
  wasm_valtype_vec_new_empty(addr(results))
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_1_0*(p: ptr wasm_valtype_t): ptr wasm_functype_t {.inline, cdecl.} =
  var ps: array[1, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 1, ps[0].addr)
  wasm_valtype_vec_new_empty(addr(results))
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_2_0*(p1: ptr wasm_valtype_t; p2: ptr wasm_valtype_t): ptr wasm_functype_t {.
    inline, cdecl.} =
  var ps: array[2, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 2, ps[0].addr)
  wasm_valtype_vec_new_empty(addr(results))
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_3_0*(p1: ptr wasm_valtype_t; p2: ptr wasm_valtype_t;
                           p3: ptr wasm_valtype_t): ptr wasm_functype_t {.inline,
    cdecl.} =
  var ps: array[3, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 3, ps[0].addr)
  wasm_valtype_vec_new_empty(addr(results))
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_0_1*(r: ptr wasm_valtype_t): ptr wasm_functype_t {.inline, cdecl.} =
  var rs: array[1, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new_empty(addr(params))
  wasm_valtype_vec_new(addr(results), 1, rs[0].addr)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_1_1*(p: ptr wasm_valtype_t; r: ptr wasm_valtype_t): ptr wasm_functype_t {.
    inline, cdecl.} =
  var ps: array[1, ptr wasm_valtype_t]
  var rs: array[1, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 1, ps[0].addr)
  wasm_valtype_vec_new(addr(results), 1, rs[0].addr)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_2_1*(p1: ptr wasm_valtype_t; p2: ptr wasm_valtype_t;
                           r: ptr wasm_valtype_t): ptr wasm_functype_t {.inline, cdecl.} =
  var ps: array[2, ptr wasm_valtype_t]
  var rs: array[1, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 2, ps[0].addr)
  wasm_valtype_vec_new(addr(results), 1, rs[0].addr)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_3_1*(p1: ptr wasm_valtype_t; p2: ptr wasm_valtype_t;
                           p3: ptr wasm_valtype_t; r: ptr wasm_valtype_t): ptr wasm_functype_t {.
    inline, cdecl.} =
  var ps: array[3, ptr wasm_valtype_t]
  var rs: array[1, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 3, ps)
  wasm_valtype_vec_new(addr(results), 1, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_0_2*(r1: ptr wasm_valtype_t; r2: ptr wasm_valtype_t): ptr wasm_functype_t {.
    inline, cdecl.} =
  var rs: array[2, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new_empty(addr(params))
  wasm_valtype_vec_new(addr(results), 2, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_1_2*(p: ptr wasm_valtype_t; r1: ptr wasm_valtype_t;
                           r2: ptr wasm_valtype_t): ptr wasm_functype_t {.inline,
    cdecl.} =
  var ps: array[1, ptr wasm_valtype_t]
  var rs: array[2, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 1, ps)
  wasm_valtype_vec_new(addr(results), 2, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_2_2*(p1: ptr wasm_valtype_t; p2: ptr wasm_valtype_t;
                           r1: ptr wasm_valtype_t; r2: ptr wasm_valtype_t): ptr wasm_functype_t {.
    inline, cdecl.} =
  var ps: array[2, ptr wasm_valtype_t]
  var rs: array[2, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 2, ps)
  wasm_valtype_vec_new(addr(results), 2, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_functype_new_3_2*(p1: ptr wasm_valtype_t; p2: ptr wasm_valtype_t;
                           p3: ptr wasm_valtype_t; r1: ptr wasm_valtype_t;
                           r2: ptr wasm_valtype_t): ptr wasm_functype_t {.inline,
    cdecl.} =
  var ps: array[3, ptr wasm_valtype_t]
  var rs: array[2, ptr wasm_valtype_t]
  var
    params: wasm_valtype_vec_t
    results: wasm_valtype_vec_t
  wasm_valtype_vec_new(addr(params), 3, ps)
  wasm_valtype_vec_new(addr(results), 2, rs)
  return wasm_functype_new(addr(params), addr(results))

proc wasm_val_init_ptr*(`out`: ptr wasm_val_t; p: pointer) {.inline, cdecl.} =
  `out`.kind = WASM_I64
  `out`.`of`.i64 = cast[intptr_t](p)

proc wasm_val_ptr*(val: ptr wasm_val_t): pointer {.inline, cdecl.} =
  return cast[pointer](cast[intptr_t](val.`of`.i64))
]#
