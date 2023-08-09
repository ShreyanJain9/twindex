#!/usr/bin/env ruby
require_relative "app"
load_models()

Feed.from_url(ARGV[0]).process
## ????? @ShreyanJain9 Why doesn't this work.... (Comment for self)
