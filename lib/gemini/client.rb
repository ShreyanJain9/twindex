require "ffi"

module Gemini
  extend FFI::Library
  ffi_lib(Relative("./gemini.dylib"))
  attach_function(:request, :make_gemini_request, [:string], :string)
end
