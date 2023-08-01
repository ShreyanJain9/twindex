package main

import (
	"C"
	"encoding/base32"
	"strings"

	"github.com/dchest/blake2b"
)

//export GenerateHash
func GenerateHash(twtURL, twtCreated, twtText *C.char) *C.char {
	payload := C.GoString(twtURL) + "\n" + C.GoString(twtCreated) + "\n" + C.GoString(twtText)
	sum := blake2b.Sum256([]byte(payload))
	encoding := base32.StdEncoding.WithPadding(base32.NoPadding)
	hash := strings.ToLower(encoding.EncodeToString(sum[:]))
	hash = hash[len(hash)-7:]

	return C.CString(hash)
}

func main() {
	// Placeholder
}
