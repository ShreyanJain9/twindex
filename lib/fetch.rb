# typed: false
require "httparty"
require_relative "gemini/client.rb"
require_relative "gopher/client.rb"
require_relative "twt_parser"
require_relative "metadata"

module Twindex
  VERSION = "0.1.0".freeze
  HEADERS = { "User-Agent" => "Twindex/#{Twindex::VERSION} Ruby/#{RUBY_VERSION} (#{RUBY_ENGINE} #{RUBY_PLATFORM}) HTTParty/#{HTTParty::VERSION}" }.freeze
end

module FetchTwts
  class << self
    def from_http_url(feed_url)
      parse_feed(
        HTTParty.get(
          feed_url, headers: Twindex::HEADERS,
        ).body, feed_url
      )
    rescue
      return "1969-12-31T16:00:00-08:00\tInvalidFeed"
    end

    alias_method :from_https_url, :from_http_url

    def from_gopher_url(feed_url)
      parse_feed(
        Gopher.get(feed_url), feed_url
      )
    end

    def from_gemini_url(feed_url)
      parse_feed(
        Gemini.request(
          feed_url
        ), feed_url
      )
    end

    def from(url)
      url.match(/^(https?|gopher|gemini):\/\//).then { |match_data|
        match_data ? match_data[1].then { |url_type| send("from_#{url_type}_url", url) } : nil
      }
    end

    def parse_feed(text, uri)
      Twindex.extract_metadata(text).then do |metadata|
        { twts: get_twts_from(text, (metadata[:uri] || uri)),
          metadata: metadata }
      end
    end

    def get_twts_from(text, uri)
      (text
        .split("\n")
        .select { |line| line.start_with?("20") }
        .map { |line| line.split("\t") }
        .map { |line| { created_at: line[0], twt: TwtParser.parse_twt(line[1]), feed: uri } }
        .sort { |a, b| a[:created_at] <=> b[:created_at] }
        .map { |twt| twt.merge({ hash: TwtHash.twt_hash(twt[:feed], twt[:created_at], twt[:twt][:original]) }) })
    end
  end
end
