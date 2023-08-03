require "ffi"

module GopherLib
  extend FFI::Library
  ffi_lib(File.expand_path("./libgopher.so", __dir__))
  attach_function(:send_gopher_request, [:string, :int, :string, :string], :string)
end

class Gopher
  attr_reader :server, :port

  def initialize(server, port = 70)
    @server = server
    @port = port
  end

  def list_raw(path, query = "")
    GopherLib.send_gopher_request(@server, @port, path, query)
  end

  def list(path, query = "")
    list_raw(path, query)
      .lines.map(&:chomp)
      .tap { |lines| lines.pop if lines.last == "." }
      .map(&method(:parse_gopher_line))
  end

  def get(path)
    GopherLib.send_gopher_request(@server, @port, path, "")
  end

  private

  def parse_gopher_line(line)
    type, description, path, host, port = line.split("\t")

    {
      type: type[0],
      description: description,
      path: path,
      host: host,
      port: port.to_i,
    }
  end
end
