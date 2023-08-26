import net
fn gopher_uri_to_req(host string, port int, path string, query string) string {
    mut req := "${path}"
    if query.len > 0 { req += "\t${query}" }
    req += "\r\n"
    return req
}

fn send_request_to_host(address string, port int, selector string) !string {
    mut conn := net.dial_tcp("${address}:${port}") or {
        return err
    }

    conn.write_string(selector) or { return err }

	mut text := ""

	for {
		mut line := conn.read_line()
		if line.is_blank() {
			break
		}
		else {
			text += line
		}
	}

	conn.close() or { panic(err) }

	return text
}

fn make_gopher_request(host string, port int, path string, query string) string {
    req := gopher_uri_to_req(host, port, path, query)
    resp := send_request_to_host(host, port, req) or { panic(err) }
    return resp
}

[export: 'send_gopher_request']
fn send_gopher_request(host &char, port int, path &char, query &char) &char {
    server := unsafe { host.vstring() }
    path_string := unsafe { path.vstring() }
    query_str := unsafe { query.vstring() }
    rep := make_gopher_request(server, port, path_string, query_str)
    return rep.str
}
