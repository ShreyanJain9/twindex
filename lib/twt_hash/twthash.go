package main

import (
	"C"
	"encoding/base32"
	"strings"

	"github.com/dchest/blake2b"
)

// generateHash generates a twt hash based on the feed's URL, the twt's rfc3339 timestamp, and raw twt content (without the timestamp).
//
// Parameters:
// - url: the URL string.
// - created: the rfc3339 timestamp string.
// - text: the raw twt string.
//
// Return:
// - the generated hash string.
func generateHash(url, created, text string) string {
	input := url + "\n" + created + "\n" + text
	hashBytes := blake2b.Sum256([]byte(input))
	encoder := base32.StdEncoding.WithPadding(base32.NoPadding)
	hash := strings.ToLower(encoder.EncodeToString(hashBytes[:]))
	return hash[len(hash)-7:]
}

//export GenerateHash
func GenerateHash(url, created, text *C.char) *C.char {
	// A C shared library exported function for use from Ruby FFI
	hash := generateHash(C.GoString(url), C.GoString(created), C.GoString(text))
	return C.CString(hash)
}
func main() {
	// Placeholder
}
