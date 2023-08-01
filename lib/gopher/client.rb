# typed: false
require "socket"

class Gopher
  attr_reader :server, :port

  def initialize(server, port = 70)
    @server = server
    @port = port
  end

  def list_raw(path, query = "")
    send_request(path, query)
  end

  def list(path, query = "")
    list_raw(path, query)
      .lines.map(&:chomp)
      .tap { |lines| lines.pop if lines.last == "." }
      .map(&method(:parse_gopher_line))
  end

  def get(path)
    send_request(path)
  end

  private

  def send_request(path, query = "")
    TCPSocket.open(@server, @port, connect_timeout: 3) do |socket|
      request = query.empty? ? "#{path}\n" : "#{path}\t#{query}\n"
      socket.print(request)
      socket.read
    end
  rescue StandardError => e
    raise "Error: #{e.message}"
  end

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
