package main

import (
	"C"
	"encoding/base32"
	"strings"

	"github.com/dchest/blake2b"
)

//export GenerateHash
func GenerateHash(url, created, text *C.char) *C.char {
	input := C.GoString(url) + "\n" + C.GoString(created) + "\n" + C.GoString(text)
	hashBytes := blake2b.Sum256([]byte(input))
	encoder := base32.StdEncoding.WithPadding(base32.NoPadding)
	hash := strings.ToLower(encoder.EncodeToString(hashBytes[:]))
	hash = hash[len(hash)-7:]

	return C.CString(hash)
}

func main() {
	// Placeholder
}
