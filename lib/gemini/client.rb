require "ffi"

module Gemini
  extend FFI::Library
  ffi_lib(Relative("./lubgemini.so"))
  attach_function(:request, :make_gemini_request, [:string], :string)
end
