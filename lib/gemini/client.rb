require "ffi"

module Gemini
  extend FFI::Library
  ffi_lib(Relative("./libgemini.so"))
  attach_function(:request, :MakeGeminiRequest, [:string], :string)
end
