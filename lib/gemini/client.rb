require "ffi"

module Gemini
  extend FFI::Library
  ffi_lib(File.expand_path("./libgemini.so", __dir__))
  attach_function(:request, :MakeGeminiRequest, [:string], :string)
end
