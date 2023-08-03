require "ffi"

module Gopher
  extend FFI::Library
  ffi_lib(File.expand_path("./libgopher.so", __dir__))
  attach_function(:send_request, :send_gopher_request, [:string, :int, :string, :string], :string)

  def self.get(uri)
    uri.is_a?(URI) ? Gopher.send_request(uri.host, (uri.port || 70), uri.path, "") : get(URI(uri))
  end
end
