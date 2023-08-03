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
   require 'ffi'

   module GopherLib
     extend FFI::Library
     ffi_lib './libgopher.so'  # Adjust the path accordingly if not in the current directory

     # Define the C function signature
     attach_function :send_gopher_request, [:string, :int, :string, :string], :string
   end

   class Gopher
     # ... (Ruby code from the previous pure Ruby, modified to use C version of send_gopher_request implementation)
   end
   ```

   Once you have the `Gopher` class available in your Ruby script, you can use it to interact with Gopher servers.

## Example Usage

Here's an example of how to use the `Gopher` class to retrieve information from a Gopher server:

```ruby
# Instantiate the Gopher object
gopher = Gopher.new('gopher.example.com', 70)

# Retrieve a list of items from the Gopher server
path = '/'
items = gopher.list(path)

# Print the items
items.each do |item|
  puts "#{item[:type]} #{item[:description]} - #{item[:path]}"
end
```

