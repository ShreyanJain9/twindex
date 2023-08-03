# Gopher Library with Ruby Wrapper

This project provides a Gopher library implemented in C, exposed through a shared library (`.so`), and a Ruby wrapper to interact with the Gopher protocol using the library.

## Prerequisites

Before using this library, ensure you have the following installed:

- Ruby (>= 2.0)
- GCC (GNU Compiler Collection) or any C compiler
- FFI gem for Ruby (install using `gem install ffi`)

## Getting Started

1. Build the C shared library:

   ```bash
   gcc -shared -o libgopher.so gopher.c
   ```

2. Usage in Ruby:

   The Ruby wrapper allows you to interact with Gopher servers using the Gopher protocol. Here's how to use it:

   ```ruby
   require "ffi"

    module Gopher
        extend FFI::Library
        ffi_lib(File.expand_path("./libgopher.so", __dir__))
        attach_function(:send_request, :send_gopher_request, [:string, :int, :string, :string], :string)

        def self.get(uri)
            uri.is_a?(URI) ? Gopher.send_request(uri.host, (uri.port || 70), uri.path, "") : get(URI(uri))
        end
    end
   ```

   Once you have the `Gopher` class available in your Ruby script, you can use it to interact with Gopher servers.

## Example Usage

Here's an example of how to use the `Gopher` class to retrieve information from a Gopher server:

```ruby
Gopher.get("gopher://tilde.team:70/~ben/phlog/20180718-what-should-i-write-about-today.txt")
```

