import net
fn gopher_uri_to_req(host string, port int, path string, query string) string {
    return "${host}\t${port}\t${path}\t${query}\r\n"
}

fn send_request_to_host(address string, port int, selector string) !string {
    mut conn := net.dial_tcp("${address}:${port}") or {
        return err
    }

    conn.write_string(selector) or { return err }
    mut text := ""

    mut buffer := []u8{}
    for {
        mut line := conn.read_line()
        if line == "" {
            break
        }
		line += "\n"
        buffer << line.bytes()
    }
    text = buffer[0].str()
    return text

}

[export: 'make_gopher_request']
fn make_gopher_request(host string, port int, path string, query string) string {
    req := gopher_uri_to_req(host, port, path, query)
    resp := send_request_to_host(host, port, req) or { panic(err) }
    return resp
}

