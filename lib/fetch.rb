# typed: strict
require "httparty"
require_relative "gopher/client.rb"

module FetchTwts
  class << self
    extend T::Sig
    sig { params(feed_url: String).returns(T.nilable(T::Array[T::Array[String]])) }

    def from_http_url(feed_url)
      parse_twts(
        HTTParty.get(
          feed_url
        ).body, feed_url
      )
    end

    sig { params(feed_url: String).returns(T.nilable((T::Array[T::Array[String]]))) }

    def from_gopher_url(feed_url)
      parse_twts(
        Gopher
          .new(URI(
            feed_url
          )
            .host)
          .get(
            URI(feed_url)
              .path
          ), feed_url
      )
    end

    sig { params(url: String).returns(T.nilable(T::Array[T::Array[String]])) }

    def from(url)
      url_regex = /^(http|https|gopher):\/\//
      if url.match(url_regex)
        url_type = T.must(url.match(url_regex))[1]
        if ["http", "https"].include?(url_type)
          from_http_url(url)
        elsif url_type == "gopher"
          from_gopher_url(url)
        end
      else
        raise "Invalid URL: #{url}"
      end
    end

    sig { params(text: String, uri: String).returns(T.nilable(T::Array[T::Array[String]])) }

    def parse_twts(text, uri)
      text
        .split("\n")
        .reject { |line| line.start_with?("#") }
        .map { |line| line.split("\t") }
        .map { |line| [T.must(line[0]), T.must(line[1]), uri] }
    end
  end
end
