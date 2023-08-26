require "ffi"

module Gopher
  extend FFI::Library
  ffi_lib(Relative("./gopher.dylib"))
  attach_function(:send_request, :send_gopher_request, [:string, :int, :string, :string], :string)

  def self.get(uri)
    uri.is_a?(URI) ? send_request(
      uri.host, (uri.port || 70), fixpath(uri.path), ""
    ) : get(URI(uri))
  end
  def self.fixpath(path)
    if path.start_with?("/0")
      path[2..-1]
    else
      path
    end
  end
end
