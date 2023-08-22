# typed: strict
require "ffi"

module TwtHash
  extend FFI::Library
  ffi_lib(File.expand_path("./libtwthash.so", __dir__))

  attach_function(:twt_hash, :GenerateHash, [:string, :string, :string], :string)
end
