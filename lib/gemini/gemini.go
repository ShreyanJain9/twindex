package main

import (
	"C"
	"bufio"
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"net/url"
	"strconv"
	"strings"
)

func makeGeminiRequest(u string) (string, error) {
	// Parse URL
	parsed, err := url.Parse(u)
	if err != nil {
		return "", fmt.Errorf("error parsing URL: %v", err)
	}

	// Connect to server
	conn, err := tls.Dial("tcp", parsed.Host+":1965", &tls.Config{InsecureSkipVerify: true})
	if err != nil {
		return "", fmt.Errorf("failed to connect: %v", err)
	}
	defer conn.Close()

	// Send request
	conn.Write([]byte(u + "\r\n"))

	// Receive and parse response header
	reader := bufio.NewReader(conn)
	responseHeader, err := reader.ReadString('\n')
	parts := strings.Fields(responseHeader)
	status, err := strconv.Atoi(parts[0][0:1])
	meta := parts[1]

	// Switch on status code
	switch status {
	case 1, 3, 6:
		// No input, redirects or client certs
		return "", fmt.Errorf("unsupported feature")
	case 2:
		// Successful transaction
		// text/* content only
		if !strings.HasPrefix(meta, "text/") {
			return "", fmt.Errorf("unsupported type %s", meta)
		}
		// Read everything
		bodyBytes, err := ioutil.ReadAll(reader)
		if err != nil {
			return "", fmt.Errorf("error reading body: %v", err)
		}
		body := string(bodyBytes)
		return body, nil
	case 4, 5:
		return "", fmt.Errorf("error: %s", meta)
	default:
		return "", fmt.Errorf("unknown status code: %d", status)
	}
}

//export MakeGeminiRequest
func MakeGeminiRequest(u *C.char) *C.char {
	goURL := C.GoString(u)
	response, err := makeGeminiRequest(goURL)
	if err != nil {
		// Handle the error, you can log it or return an empty string for simplicity
		return C.CString("")
	}
	return C.CString(response)
}

func main() {
	// Placeholder
}
