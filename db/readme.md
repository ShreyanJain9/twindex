To set up full text search for Twts..

2. Compile the Go file into a CGo library:

```bash
go build -o twts_search.so -buildmode=c-shared twts_search.go
```

This will create a shared library named `twts_search.so`.

