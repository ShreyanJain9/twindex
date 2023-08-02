# typed: false
require "httparty"
require "net/gemini"
require_relative "gopher/client.rb"
require_relative "twt_parser"
require_relative "metadata"

module FetchTwts
  class << self
    def from_http_url(feed_url)
      get_twts_from(
        HTTParty.get(
          feed_url
        ).body, feed_url
      )
    end

    def from_gopher_url(feed_url)
      get_twts_from(
        Gopher
          .new(URI(
            feed_url
          )
            .host, URI(
            feed_url
          ).port || 70)
          .get(
            URI(feed_url)
              .path
          ), feed_url
      )
    end

    def from_gemini_url(feed_url)
      get_twts_from(
        Net::Gemini.get(
          URI(feed_url)
        ), feed_url
      )
    end

    def from(url)
      url_regex = /^(http|https|gopher|gemini):\/\//
      if url.match(url_regex)
        url_type = (url.match(url_regex))[1]
        if ["http", "https"].include?(url_type)
          from_http_url(url)
        elsif url_type == "gopher"
          from_gopher_url(url)
        elsif url_type == "gemini"
          from_gemini_url(url)
        end
      else
        raise "Invalid URL: #{url}"
      end
    end

    def get_twts_from(text, uri)
      { twts: (text
        .split("\n")
        .select { |line| line.start_with?("20") }
        .map { |line| line.split("\t") }
        .map { |line| { created_at: line[0], twt: TwtParser.parse_twt(line[1]), feed: uri } }
        .sort { |a, b| a[:created_at] <=> b[:created_at] }
        .map { |twt| twt.merge({ hash: TwtHash.twt_hash(twt[:feed], twt[:created_at], twt[:twt][:original]) }) }),
        metadata: Twindex.extract_metadata(text) }
    end
  end
end
