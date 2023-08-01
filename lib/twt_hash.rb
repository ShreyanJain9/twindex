require "ffi"

module TwtHash
  extend FFI::Library
  ffi_lib "./lib/go/lib/libtwthash.so"

  attach_function :twt_hash, :GenerateHash, [:string, :string, :string], :string
end
