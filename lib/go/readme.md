The Go code in twthash.go is meant to be used from Ruby through FFI.

```go
func GenerateHash(twtURL, twtCreated, twtText *C.char) *C.char {
	payload := C.GoString(twtURL) + "\n" + C.GoString(twtCreated) + "\n" + C.GoString(twtText)
	sum := blake2b.Sum256([]byte(payload))
	encoding := base32.StdEncoding.WithPadding(base32.NoPadding)
	hash := strings.ToLower(encoding.EncodeToString(sum[:]))
	hash = hash[len(hash)-7:]

	return C.CString(hash)
}
```

This Go code exports a function called GenerateHash.
It takes three *C.char parameters representing URL, creation timestamp, and text.
It concatenates them into a payload string, computes the Blake2b hash of the payload,
encodes the hash as a lowercase base32 string,
and returns the last 7 characters of the encoded hash as a new *C.char string.

Compile the Go code in the `lib/go` folder by running `go build -o lib/libtwthash.so -buildmode=c-shared twthash.go`.

To run the accompanying Ruby code, it must be required from the toplevel `twindex` folder.

It's located at `lib/twt_hash.rb` and registers the function under the `TwtHash` module:
```ruby
require "ffi"

module TwtHash
  extend FFI::Library
  ffi_lib "./lib/go/lib/libtwthash.so"

  attach_function :twt_hash, :GenerateHash, [:string, :string, :string], :string
end
```
