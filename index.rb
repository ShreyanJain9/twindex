#!/usr/bin/env ruby
require_relative "app"
load_models()

Feed.from_url(ARGV[0]).process
