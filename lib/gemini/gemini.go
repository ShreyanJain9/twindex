package main

import (
	"C"
	"bufio"
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"net"
	"net/url"
	"strconv"
	"strings"
)

// makeGeminiRequest makes a request to a Gemini server and returns the response body or an error.
//
// Parameters:
// - u: the URL to make the request to.
//
// Returns:
// - string: the response body if the request was successful.
// - error: an error if there was a problem making the request or processing the response.
func makeGeminiRequest(u string) (string, error) {
	parsed, err := parseURL(u)
	if err != nil {
		return "", fmt.Errorf("error parsing URL: %v", err)
	}

	conn, err := connectToServer(parsed)
	if err != nil {
		return "", fmt.Errorf("failed to connect: %v", err)
	}
	defer conn.Close()

	conn.Write([]byte(u + "\r\n"))

	responseHeader, err := receiveResponseHeader(conn)
	if err != nil {
		return "", fmt.Errorf("error receiving response header: %v", err)
	}

	status, meta, err := parseResponseHeader(responseHeader)
	if err != nil {
		return "", fmt.Errorf("error parsing response header: %v", err)
	}

	switch status {
	case 1, 3, 6:
		return "", fmt.Errorf("unsupported feature")
	case 2:
		if !isTextType(meta) {
			return "", fmt.Errorf("unsupported type %s", meta)
		}
		body, err := readResponseBody(conn)
		if err != nil {
			return "", fmt.Errorf("error reading body: %v", err)
		}
		return body, nil
	case 4, 5:
		return "", fmt.Errorf("error: %s", meta)
	default:
		return "", fmt.Errorf("unknown status code: %d", status)
	}
}

func parseURL(u string) (*url.URL, error) {
	parsed, err := url.Parse(u)
	if err != nil {
		return nil, err
	}
	return parsed, nil
}

// connectToServer connects to the server using the provided URL.
//
// It takes a parsed URL as the parameter and returns a net.Conn and an error.
func connectToServer(parsed *url.URL) (net.Conn, error) {
	conn, err := tls.Dial("tcp", parsed.Host+":1965", &tls.Config{InsecureSkipVerify: true})
	if err != nil {
		return nil, err
	}
	return conn, nil
}

// receiveResponseHeader is a function that reads a response header from a network connection.
//
// It takes a net.Conn parameter `conn` which represents the network connection to read from.
// The function returns a string which represents the response header, and an error if any occurred.
func receiveResponseHeader(conn net.Conn) (string, error) {
	reader := bufio.NewReader(conn)
	responseHeader, err := reader.ReadString('\n')
	if err != nil {
		return "", err
	}
	return responseHeader, nil
}

// parseResponseHeader parses the response header and returns the status code,
// meta information, and any error encountered during the parsing.
//
// responseHeader: The response header to be parsed.
//
// Returns:
//   - int: The status code extracted from the response header.
//   - string: The meta information extracted from the response header.
//   - error: Any error encountered during the parsing.
func parseResponseHeader(responseHeader string) (int, string, error) {
	parts := strings.Fields(responseHeader)
	status, err := strconv.Atoi(parts[0][0:1])
	if err != nil {
		return 0, "", err
	}
	meta := parts[1]
	return status, meta, nil
}

// isTextType checks if the given meta string has a prefix of "text/".
//
// meta: the string to check
// returns: true if the meta string has a prefix of "text/", false otherwise
func isTextType(meta string) bool {
	return strings.HasPrefix(meta, "text/")
}

// readResponseBody reads the response body from the given network connection.
//
// conn: The network connection to read from.
// Returns the response body as a string and any error that occurred.
func readResponseBody(conn net.Conn) (string, error) {
	bodyBytes, err := ioutil.ReadAll(conn)
	if err != nil {
		return "", err
	}
	body := string(bodyBytes)
	return body, nil
}

//export MakeGeminiRequest
func MakeGeminiRequest(u *C.char) *C.char {
	goURL := C.GoString(u)
	response, err := makeGeminiRequest(goURL)
	if err != nil {
		return C.CString(err.Error())
	}
	return C.CString(response)
}

func main() {
	// Placeholder
}
