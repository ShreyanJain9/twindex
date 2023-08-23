# typed: strict
require "ffi"

module TwtHash
  extend FFI::Library
  ffi_lib(Relative("./libtwthash.so"))

  attach_function(:twt_hash, :GenerateHash, [:string, :string, :string], :string)
end
