import net
import net.openssl
import io
import net.urllib

fn connect_to_server(host string) !&openssl.SSLConn {
	mut conn :=  openssl.new_ssl_conn(openssl.SSLConnectConfig{validate: false}) or { panic(error("Creating SSL connection failed")) }
	conn.dial(host, 1965) or { error("Could not connect to host") }
	return conn
}

fn open_gemini_url(u string, mut conn openssl.SSLConn) !int {
	return conn.write("${u}\r\n".bytes())!
}

fn receive_response_header_and_body(mut conn &openssl.SSLConn) []string {
	mut reader := io.new_buffered_reader(io.BufferedReaderConfig{reader: mut conn})
	header := reader.read_line() or { err.str() }
	if parse_response_header(header).should_open() {
		read_all_config := io.ReadAllConfig{read_to_end_of_stream: true, reader: reader}
		body := io.read_all(read_all_config) or { "Error".bytes() }
		return [header, body.bytestr()]
	}
	else {
		return [header, "1969-12-31T16:00:00-08:00\tInvalidFeed"]
	}
}

fn parse_response_header(response_header string) ResponseHeader {
	parts := response_header.split(' ')
	status := parts[0].int()
	meta := parts[1]
	return ResponseHeader{status: status, meta: meta}
}

struct ResponseHeader {
	status int
	meta string
}

fn is_text_type(meta string) bool {
	return meta.starts_with("text/")
}

// Whether or not to recieve the body
fn (h ResponseHeader) should_open() bool {
	match h.status {
		20 {
			if is_text_type(h.meta) {
				return true
			}
			else {
				return false
			}
		}
		else {
			return false
		}
	}
}

fn send_gemini_request(url string ) string {
	uri := urllib.parse(url) or { panic("Bad URI ${url}") }
	mut connection := connect_to_server(uri.host) or { return("${url} was not found")}
	defer {
		connection.shutdown() or { panic("Could Not Close Connection to ${url}!! This is Very Bad.") }
	}

	open_gemini_url(url, mut connection) or { 6 }
	response := receive_response_header_and_body(mut connection)
	return response[1]
}


[export: 'make_gemini_request']
fn c_interface_send_gemini_request(u &char) &char {
	url := unsafe { cstring_to_vstring(u) }
	resp := send_gemini_request(url)
	return resp.str
}
