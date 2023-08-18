# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rack-contrib` gem.
# Please instead update this file by running `bin/tapioca gem rack-contrib`.

# TODO: optional stats
# TODO: performance
# TODO: clean up tests
#
# source://rack-contrib//lib/rack/contrib.rb#5
module Rack
  class << self
    # source://rack/2.2.8/lib/rack/version.rb#26
    def release; end

    # source://rack/2.2.8/lib/rack/version.rb#19
    def version; end
  end
end

# Rack middleware for limiting access based on IP address
#
#
# === Options:
#
#   path => ipmasks      ipmasks: Array of remote addresses which are allowed to access
#
# === Examples:
#
#  use Rack::Access, '/backend' => [ '127.0.0.1',  '192.168.1.0/24' ]
#
# source://rack-contrib//lib/rack/contrib/access.rb#21
class Rack::Access
  # @return [Access] a new instance of Access
  #
  # source://rack-contrib//lib/rack/contrib/access.rb#25
  def initialize(app, options = T.unsafe(nil)); end

  # source://rack-contrib//lib/rack/contrib/access.rb#52
  def call(env); end

  # source://rack-contrib//lib/rack/contrib/access.rb#74
  def forbidden!; end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/access.rb#78
  def ip_authorized?(request, ipmasks); end

  # source://rack-contrib//lib/rack/contrib/access.rb#60
  def ipmasks_for_path(env); end

  # Returns the value of attribute options.
  #
  # source://rack-contrib//lib/rack/contrib/access.rb#23
  def options; end

  # source://rack-contrib//lib/rack/contrib/access.rb#31
  def remap(mapping); end
end

# Bounce those annoying favicon.ico requests
#
# source://rack-contrib//lib/rack/contrib/bounce_favicon.rb#5
class Rack::BounceFavicon
  # @return [BounceFavicon] a new instance of BounceFavicon
  #
  # source://rack-contrib//lib/rack/contrib/bounce_favicon.rb#6
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/bounce_favicon.rb#10
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/callbacks.rb#4
class Rack::Callbacks
  # @return [Callbacks] a new instance of Callbacks
  #
  # source://rack-contrib//lib/rack/contrib/callbacks.rb#5
  def initialize(&block); end

  # source://rack-contrib//lib/rack/contrib/callbacks.rb#19
  def after(middleware, *args, &block); end

  # source://rack-contrib//lib/rack/contrib/callbacks.rb#11
  def before(middleware, *args, &block); end

  # source://rack-contrib//lib/rack/contrib/callbacks.rb#31
  def call(env); end

  # source://rack-contrib//lib/rack/contrib/callbacks.rb#27
  def run(app); end
end

# source://rack-contrib//lib/rack/contrib.rb#6
module Rack::Contrib
  class << self
    # source://rack-contrib//lib/rack/contrib.rb#7
    def release; end
  end
end

# source://rack-contrib//lib/rack/contrib/cookies.rb#4
class Rack::Cookies
  # @return [Cookies] a new instance of Cookies
  #
  # source://rack-contrib//lib/rack/contrib/cookies.rb#39
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/cookies.rb#43
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/cookies.rb#5
class Rack::Cookies::CookieJar < ::Hash
  # @return [CookieJar] a new instance of CookieJar
  #
  # source://rack-contrib//lib/rack/contrib/cookies.rb#6
  def initialize(cookies); end

  # source://rack-contrib//lib/rack/contrib/cookies.rb#13
  def [](name); end

  # source://rack-contrib//lib/rack/contrib/cookies.rb#17
  def []=(key, options); end

  # source://rack-contrib//lib/rack/contrib/cookies.rb#27
  def delete(key, options = T.unsafe(nil)); end

  # source://rack-contrib//lib/rack/contrib/cookies.rb#33
  def finish!(resp); end
end

# Rack middleware for protecting against Denial-of-service attacks
# http://en.wikipedia.org/wiki/Denial-of-service_attack.
#
# This middleware is designed for small deployments, which most likely
# are not utilizing load balancing from other software or hardware. Deflect
# current supports the following functionality:
#
# * Saturation prevention (small DoS attacks, or request abuse)
# * Blacklisting of remote addresses
# * Whitelisting of remote addresses
# * Logging
#
# === Options:
#
#   :log                When false logging will be bypassed, otherwise pass an object responding to #puts
#   :log_format         Alter the logging format
#   :log_date_format    Alter the logging date format
#   :request_threshold  Number of requests allowed within the set :interval. Defaults to 100
#   :interval           Duration in seconds until the request counter is reset. Defaults to 5
#   :block_duration     Duration in seconds that a remote address will be blocked. Defaults to 900 (15 minutes)
#   :whitelist          Array of remote addresses which bypass Deflect. NOTE: this does not block others
#   :blacklist          Array of remote addresses immediately considered malicious
#
# === Examples:
#
#  use Rack::Deflect, :log => $stdout, :request_threshold => 20, :interval => 2, :block_duration => 60
#
# CREDIT: TJ Holowaychuk <tj@vision-media.ca>
#
# source://rack-contrib//lib/rack/contrib/deflect.rb#42
class Rack::Deflect
  # @return [Deflect] a new instance of Deflect
  #
  # source://rack-contrib//lib/rack/contrib/deflect.rb#46
  def initialize(app, options = T.unsafe(nil)); end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#102
  def block!(remote_addr); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/deflect.rb#112
  def block_expired?(remote_addr); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/deflect.rb#108
  def blocked?(remote_addr); end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#61
  def call(env); end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#120
  def clear!(remote_addr); end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#67
  def deflect!; end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/deflect.rb#71
  def deflect?(env); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/deflect.rb#130
  def exceeded_request_threshold?(remote_addr); end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#126
  def increment_requests(remote_addr); end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#78
  def log(message); end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#87
  def map(remote_addr); end

  # Returns the value of attribute options.
  #
  # source://rack-contrib//lib/rack/contrib/deflect.rb#44
  def options; end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#83
  def sync(&block); end

  # source://rack-contrib//lib/rack/contrib/deflect.rb#94
  def watch(remote_addr); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/deflect.rb#134
  def watch_expired?(remote_addr); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/deflect.rb#116
  def watching?(remote_addr); end
end

# Ensure that the path and query string presented to the application
# contains only valid characters.  If the validation fails, then a
# 400 Bad Request response is returned immediately.
#
# Requires: Ruby 1.9
#
# source://rack-contrib//lib/rack/contrib/enforce_valid_encoding.rb#10
class Rack::EnforceValidEncoding
  # @return [EnforceValidEncoding] a new instance of EnforceValidEncoding
  #
  # source://rack-contrib//lib/rack/contrib/enforce_valid_encoding.rb#11
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/enforce_valid_encoding.rb#15
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/evil.rb#4
class Rack::Evil
  # Lets you return a response to the client immediately from anywhere ( M V or C ) in the code.
  #
  # @return [Evil] a new instance of Evil
  #
  # source://rack-contrib//lib/rack/contrib/evil.rb#6
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/evil.rb#10
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#4
class Rack::ExpectationCascade
  # @return [ExpectationCascade] a new instance of ExpectationCascade
  # @yield [_self]
  # @yieldparam _self [Rack::ExpectationCascade] the object that the method was called on
  #
  # source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#13
  def initialize; end

  # source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#30
  def <<(app); end

  # Returns the value of attribute apps.
  #
  # source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#11
  def apps; end

  # source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#18
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#6
Rack::ExpectationCascade::ContinueExpectation = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#5
Rack::ExpectationCascade::Expect = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#8
Rack::ExpectationCascade::ExpectationFailed = T.let(T.unsafe(nil), Array)

# source://rack-contrib//lib/rack/contrib/expectation_cascade.rb#9
Rack::ExpectationCascade::NotFound = T.let(T.unsafe(nil), Array)

# Forces garbage collection after each request.
#
# source://rack-contrib//lib/rack/contrib/garbagecollector.rb#5
class Rack::GarbageCollector
  # @return [GarbageCollector] a new instance of GarbageCollector
  #
  # source://rack-contrib//lib/rack/contrib/garbagecollector.rb#6
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/garbagecollector.rb#10
  def call(env); end
end

# Rack middleware implementing the IETF draft: "Host Metadata for the Web"
# including support for Link-Pattern elements as described in the IETF draft:
# "Link-based Resource Descriptor Discovery."
#
# Usage:
#  use Rack::HostMeta do
#    link :uri => '/robots.txt', :rel => 'robots'
#    link :uri => '/w3c/p3p.xml', :rel => 'privacy', :type => 'application/p3p.xml'
#    link :pattern => '{uri};json_schema', :rel => 'describedby', :type => 'application/x-schema+json'
#  end
#
# See also:
#   http://tools.ietf.org/html/draft-nottingham-site-meta
#   http://tools.ietf.org/html/draft-hammer-discovery
#
# TODO:
#   Accept POST operations allowing downstream services to register themselves
#
# source://rack-contrib//lib/rack/contrib/host_meta.rb#23
class Rack::HostMeta
  # @return [HostMeta] a new instance of HostMeta
  #
  # source://rack-contrib//lib/rack/contrib/host_meta.rb#24
  def initialize(app, &block); end

  # source://rack-contrib//lib/rack/contrib/host_meta.rb#31
  def call(env); end

  protected

  # source://rack-contrib//lib/rack/contrib/host_meta.rb#41
  def link(config); end
end

# A Rack middleware that makes JSON-encoded request bodies available in the
# request.params hash. By default it parses POST, PATCH, and PUT requests
# whose media type is <tt>application/json</tt>. You can configure it to match
# any verb or media type via the <tt>:verbs</tt> and <tt>:media</tt> options.
#
#
# == Examples:
#
# === Parse POST and GET requests only
#   use Rack::JSONBodyParser, verbs: ['POST', 'GET']
#
# === Parse POST|PATCH|PUT requests whose Content-Type matches 'json'
#   use Rack::JSONBodyParser, media: /json/
#
# === Parse POST requests whose Content-Type is 'application/json' or 'application/vnd+json'
#   use Rack::JSONBodyParser, verbs: ['POST'], media: ['application/json', 'application/vnd.api+json']
#
# source://rack-contrib//lib/rack/contrib/json_body_parser.rb#23
class Rack::JSONBodyParser
  # @return [JSONBodyParser] a new instance of JSONBodyParser
  #
  # source://rack-contrib//lib/rack/contrib/json_body_parser.rb#45
  def initialize(app, verbs: T.unsafe(nil), media: T.unsafe(nil), &block); end

  # source://rack-contrib//lib/rack/contrib/json_body_parser.rb#57
  def call(env); end

  private

  # source://rack-contrib//lib/rack/contrib/json_body_parser.rb#74
  def update_form_hash_with_json_body(env); end
end

# source://rack-contrib//lib/rack/contrib/json_body_parser.rb#24
Rack::JSONBodyParser::CONTENT_TYPE_MATCHERS = T.let(T.unsafe(nil), Hash)

# source://rack-contrib//lib/rack/contrib/json_body_parser.rb#43
Rack::JSONBodyParser::DEFAULT_PARSER = T.let(T.unsafe(nil), Proc)

# A Rack middleware for providing JSON-P support.
#
# Full credit to Flinn Mueller (http://actsasflinn.com/) for this contribution.
#
# source://rack-contrib//lib/rack/contrib/jsonp.rb#9
class Rack::JSONP
  include ::Rack::Utils

  # @return [JSONP] a new instance of JSONP
  #
  # source://rack-contrib//lib/rack/contrib/jsonp.rb#26
  def initialize(app); end

  # Proxies the request to the application, stripping out the JSON-P callback
  # method and padding the response with the appropriate callback format if
  # the returned body is application/json
  #
  # Changes nothing if no <tt>callback</tt> param is specified.
  #
  # source://rack-contrib//lib/rack/contrib/jsonp.rb#36
  def call(env); end

  private

  # source://rack-contrib//lib/rack/contrib/jsonp.rb#110
  def bad_request(body = T.unsafe(nil)); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/jsonp.rb#72
  def has_callback?(request); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/jsonp.rb#68
  def is_json?(headers); end

  # Pads the response with the appropriate callback format according to the
  # JSON-P spec/requirements.
  #
  # The Rack response spec indicates that it should be enumerable. The
  # method of combining all of the data into a single string makes sense
  # since JSON is returned as a full string.
  #
  # source://rack-contrib//lib/rack/contrib/jsonp.rb#92
  def pad(callback, response); end

  # See:
  # http://stackoverflow.com/questions/1661197/valid-characters-for-javascript-variable-names
  #
  # NOTE: Supports dots (.) since callbacks are often in objects:
  #
  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/jsonp.rb#81
  def valid_callback?(callback); end
end

# source://rack-contrib//lib/rack/contrib/jsonp.rb#24
Rack::JSONP::U2028 = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/jsonp.rb#24
Rack::JSONP::U2029 = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/jsonp.rb#12
Rack::JSONP::VALID_CALLBACK = T.let(T.unsafe(nil), Regexp)

# This middleware is like Rack::ConditionalGet except that it does
# not have to go down the rack stack and build the resource to check
# the modification date or the ETag.
#
# Instead it makes the assumption that only non-reading requests can
# potentially change the content, meaning any request which is not
# GET or HEAD. Each time you make one of these request, the date is cached
# and any resource is considered identical until the next non-reading request.
#
# Basically you use it this way:
#
# ``` ruby
# use Rack::LazyConditionalGet
# ```
#
# Although if you have multiple instances, it is better to use something like
# memcached. An argument can be passed to give the cache object. By default
# it is just a Hash. But it can take other objects, including objects which
# respond to `:get` and `:set`. Here is how you would use it with Dalli.
#
# ``` Ruby
# dalli_client = Dalli::Client.new
# use Rack::LazyConditionalGet, dalli_client
# ```
#
# By default, the middleware only delegates to Rack::ConditionalGet to avoid
# any unwanted behaviour. You have to set a header to any resource which you
# want to be cached. And it will be cached until the next "potential update"
# of your site, that is whenever the next POST/PUT/PATCH/DELETE request
# is received.
#
# The header is `Rack-Lazy-Conditional-Get`. You have to set it to 'yes'
# if you want the middleware to set `Last-Modified` for you.
#
# Bear in mind that if you set `Last-Modified` as well, the middleware will
# not change it.
#
# Regarding the POST/PUT/PATCH/DELETE... requests, they will always reset your
# global modification date. But if you have one of these request and you
# know for sure that it does not modify the cached content, you can set the
# `Rack-Lazy-Conditional-Get` on response to `skip`. This will not update the
# global modification date.
#
# NOTE: This will not work properly in a multi-threaded environment with
# default cache object. A provided cache object should ensure thread-safety
# of the `get`/`set`/`[]`/`[]=` methods.
#
# source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#53
class Rack::LazyConditionalGet
  # @return [LazyConditionalGet] a new instance of LazyConditionalGet
  #
  # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#69
  def initialize(app, cache = T.unsafe(nil)); end

  # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#75
  def call(env); end

  private

  # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#115
  def cached_value; end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#90
  def fresh?(env); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#94
  def reading?(env); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#98
  def skipping?(headers); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#102
  def stampable?(headers); end

  # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#106
  def update_cache; end

  class << self
    # source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#58
    def new(*_arg0); end
  end
end

# source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#55
Rack::LazyConditionalGet::KEY = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/lazy_conditional_get.rb#56
Rack::LazyConditionalGet::READ_METHODS = T.let(T.unsafe(nil), Array)

# Lighttpd sets the wrong SCRIPT_NAME and PATH_INFO if you mount your
# FastCGI app at "/". This middleware fixes this issue.
#
# source://rack-contrib//lib/rack/contrib/lighttpd_script_name_fix.rb#7
class Rack::LighttpdScriptNameFix
  # @return [LighttpdScriptNameFix] a new instance of LighttpdScriptNameFix
  #
  # source://rack-contrib//lib/rack/contrib/lighttpd_script_name_fix.rb#8
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/lighttpd_script_name_fix.rb#12
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/locale.rb#6
class Rack::Locale
  # @return [Locale] a new instance of Locale
  #
  # source://rack-contrib//lib/rack/contrib/locale.rb#7
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/locale.rb#11
  def call(env); end

  private

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/locale.rb#80
  def match?(s1, s2); end

  # Accept-Language header is covered mainly by RFC 7231
  # https://tools.ietf.org/html/rfc7231
  #
  # Related sections:
  #
  # * https://tools.ietf.org/html/rfc7231#section-5.3.1
  # * https://tools.ietf.org/html/rfc7231#section-5.3.5
  # * https://tools.ietf.org/html/rfc4647#section-3.4
  #
  # There is an obsolete RFC 2616 (https://tools.ietf.org/html/rfc2616)
  #
  # Edge cases:
  #
  # * Value can be a comma separated list with optional whitespaces:
  #   Accept-Language: da, en-gb;q=0.8, en;q=0.7
  #
  # * Quality value can contain optional whitespaces as well:
  #   Accept-Language: ru-UA, ru; q=0.8, uk; q=0.6, en-US; q=0.4, en; q=0.2
  #
  # * Quality prefix 'q=' can be in upper case (Q=)
  #
  # * Ignore case when match locale with I18n available locales
  #
  # source://rack-contrib//lib/rack/contrib/locale.rb#55
  def user_preferred_locale(header); end
end

# Rack middleware for parsing POST/PUT body data into nested parameters
#
# source://rack-contrib//lib/rack/contrib/nested_params.rb#7
class Rack::NestedParams
  # @return [NestedParams] a new instance of NestedParams
  #
  # source://rack-contrib//lib/rack/contrib/nested_params.rb#18
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/nested_params.rb#22
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/nested_params.rb#9
Rack::NestedParams::CONTENT_TYPE = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/nested_params.rb#12
Rack::NestedParams::FORM_HASH = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/nested_params.rb#11
Rack::NestedParams::FORM_INPUT = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/nested_params.rb#13
Rack::NestedParams::FORM_VARS = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/nested_params.rb#10
Rack::NestedParams::POST_BODY = T.let(T.unsafe(nil), String)

# supported content type
#
# source://rack-contrib//lib/rack/contrib/nested_params.rb#16
Rack::NestedParams::URL_ENCODED = T.let(T.unsafe(nil), String)

# Rack::NotFound is a default endpoint. Optionally initialize with the
# path to a custom 404 page, to override the standard response body.
#
# Examples:
#
# Serve default 404 response:
#   run Rack::NotFound.new
#
# Serve a custom 404 page:
#   run Rack::NotFound.new('path/to/your/404.html')
#
# source://rack-contrib//lib/rack/contrib/not_found.rb#15
class Rack::NotFound
  # @return [NotFound] a new instance of NotFound
  #
  # source://rack-contrib//lib/rack/contrib/not_found.rb#18
  def initialize(path = T.unsafe(nil), content_type = T.unsafe(nil)); end

  # source://rack-contrib//lib/rack/contrib/not_found.rb#29
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/not_found.rb#16
Rack::NotFound::F = File

# <b>DEPRECATED:</b> <tt>JSONBodyParser</tt> is a drop-in replacement that is faster and more configurable.
#
# A Rack middleware for parsing POST/PUT body data when Content-Type is
# not one of the standard supported types, like <tt>application/json</tt>.
#
# === How to use the middleware
#
# Example of simple +config.ru+ file:
#
#  require 'rack'
#  require 'rack/contrib'
#
#  use ::Rack::PostBodyContentTypeParser
#
#  app = lambda do |env|
#    request = Rack::Request.new(env)
#    body = "Hello #{request.params['name']}"
#    [200, {'Content-Type' => 'text/plain'}, [body]]
#  end
#
#  run app
#
# Example with passing block argument:
#
#   use ::Rack::PostBodyContentTypeParser do |body|
#     { 'params' => JSON.parse(body) }
#   end
#
# Example with passing proc argument:
#
#   parser = ->(body) { { 'params' => JSON.parse(body) } }
#   use ::Rack::PostBodyContentTypeParser, &parser
#
#
# === Failed JSON parsing
#
# Returns "400 Bad request" response if invalid JSON document was sent:
#
# Raw HTTP response:
#
#   HTTP/1.1 400 Bad Request
#   Content-Type: text/plain
#   Content-Length: 28
#
#   failed to parse body as JSON
#
# source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#57
class Rack::PostBodyContentTypeParser
  # @return [PostBodyContentTypeParser] a new instance of PostBodyContentTypeParser
  #
  # source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#70
  def initialize(app, &block); end

  # source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#86
  def bad_request(body = T.unsafe(nil)); end

  # source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#76
  def call(env); end
end

# Supported Content-Types
#
# source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#68
Rack::PostBodyContentTypeParser::APPLICATION_JSON = T.let(T.unsafe(nil), String)

# Constants
#
# source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#61
Rack::PostBodyContentTypeParser::CONTENT_TYPE = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#64
Rack::PostBodyContentTypeParser::FORM_HASH = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#63
Rack::PostBodyContentTypeParser::FORM_INPUT = T.let(T.unsafe(nil), String)

# source://rack-contrib//lib/rack/contrib/post_body_content_type_parser.rb#62
Rack::PostBodyContentTypeParser::POST_BODY = T.let(T.unsafe(nil), String)

# prints the environment and request for simple debugging
#
# source://rack-contrib//lib/rack/contrib/printout.rb#5
class Rack::Printout
  # @return [Printout] a new instance of Printout
  #
  # source://rack-contrib//lib/rack/contrib/printout.rb#6
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/printout.rb#10
  def call(env); end
end

# Middleware to update the process title ($0) with information about the
# current request. Based loosely on:
# - http://purefiction.net/mongrel_proctitle/
# - http://github.com/grempe/thin-proctitle/tree/master
#
# NOTE: This will not work properly in a multi-threaded environment.
#
# source://rack-contrib//lib/rack/contrib/proctitle.rb#10
class Rack::ProcTitle
  # @return [ProcTitle] a new instance of ProcTitle
  #
  # source://rack-contrib//lib/rack/contrib/proctitle.rb#14
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/proctitle.rb#22
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/proctitle.rb#11
Rack::ProcTitle::F = File

# source://rack-contrib//lib/rack/contrib/proctitle.rb#12
Rack::ProcTitle::PROGNAME = T.let(T.unsafe(nil), String)

# Rack::RelativeRedirect is a simple middleware that converts relative paths in
# redirects in absolute urls, so they conform to RFC2616. It allows the user to
# specify the absolute path to use (with a sensible default), and handles
# relative paths (those that don't start with a slash) as well.
#
# source://rack-contrib//lib/rack/contrib/relative_redirect.rb#9
class Rack::RelativeRedirect
  # Initialize a new RelativeRedirect object with the given arguments.  Arguments:
  # * app : The next middleware in the chain.  This is always called.
  # * &block : If provided, it is called with the environment and the response
  #   from the next middleware. It should return a string representing the scheme
  #   and server name (such as 'http://example.org').
  #
  # @return [RelativeRedirect] a new instance of RelativeRedirect
  #
  # source://rack-contrib//lib/rack/contrib/relative_redirect.rb#24
  def initialize(app, &block); end

  # Call the next middleware with the environment.  If the request was a
  # redirect (response status 301, 302, or 303), and the location header does
  # not start with an http or https url scheme, call the block provided by new
  # and use that to make the Location header an absolute url.  If the Location
  # does not start with a slash, make location relative to the path requested.
  #
  # source://rack-contrib//lib/rack/contrib/relative_redirect.rb#34
  def call(env); end
end

# The default proc used if a block is not provided to .new
# Just uses the url scheme of the request and the server name.
#
# source://rack-contrib//lib/rack/contrib/relative_redirect.rb#13
Rack::RelativeRedirect::DEFAULT_ABSOLUTE_PROC = T.let(T.unsafe(nil), Proc)

# source://rack-contrib//lib/rack/contrib/relative_redirect.rb#10
Rack::RelativeRedirect::SCHEME_MAP = T.let(T.unsafe(nil), Hash)

# Rack::ResponseCache is a Rack middleware that caches responses for successful
# GET requests with no query string to disk or any ruby object that has an
# []= method (so it works with memcached). As with Rails' page caching, this
# middleware only writes to the cache -- it never reads. The logic of whether a
# cached response should be served is left either to your web server, via
# something like the <tt>try_files</tt> directive in nginx, or to your
# cache-reading middleware of choice, mounted before Rack::ResponseCache in the
# stack.
#
# source://rack-contrib//lib/rack/contrib/response_cache.rb#14
class Rack::ResponseCache
  # Initialize a new ResponseCache object with the given arguments.  Arguments:
  # * app : The next middleware in the chain.  This is always called.
  # * cache : The place to cache responses.  If a string is provided, a disk
  #   cache is used, and all cached files will use this directory as the root directory.
  #   If anything other than a string is provided, it should respond to []=, which will
  #   be called with a path string and a body value (the 3rd element of the response).
  # * &block : If provided, it is called with the environment and the response from the next middleware.
  #   It should return nil or false if the path should not be cached, and should return
  #   the pathname to use as a string if the result should be cached.
  #   If not provided, the DEFAULT_PATH_PROC is used.
  #
  # @return [ResponseCache] a new instance of ResponseCache
  #
  # source://rack-contrib//lib/rack/contrib/response_cache.rb#44
  def initialize(app, cache, &block); end

  # Call the next middleware with the environment.  If the request was successful (response status 200),
  # was a GET request, and had an empty query string, call the block set up in initialize to get the path.
  # If the cache is a string, create any necessary middle directories, and cache the file in the appropriate
  # subdirectory of cache.  Otherwise, cache the body of the response as the value with the path as the key.
  #
  # source://rack-contrib//lib/rack/contrib/response_cache.rb#54
  def call(env); end
end

# The default proc used if a block is not provided to .new
# It unescapes the PATH_INFO of the environment, and makes sure that it doesn't
# include '..'.  If the Content-Type of the response is text/(html|css|xml),
# return a path with the appropriate extension (.html, .css, or .xml).
# If the path ends with a / and the Content-Type is text/html, change the basename
# of the path to index.html.
#
# source://rack-contrib//lib/rack/contrib/response_cache.rb#21
Rack::ResponseCache::DEFAULT_PATH_PROC = T.let(T.unsafe(nil), Proc)

# Allows you to tap into the response headers. Yields a Rack::Utils::HeaderHash
# of current response headers to the block. Example:
#
#   use Rack::ResponseHeaders do |headers|
#     headers['X-Foo'] = 'bar'
#     headers.delete('X-Baz')
#   end
#
# source://rack-contrib//lib/rack/contrib/response_headers.rb#12
class Rack::ResponseHeaders
  # @return [ResponseHeaders] a new instance of ResponseHeaders
  #
  # source://rack-contrib//lib/rack/contrib/response_headers.rb#13
  def initialize(app, &block); end

  # source://rack-contrib//lib/rack/contrib/response_headers.rb#18
  def call(env); end
end

# Installs signal handlers that are safely processed after a request
#
# NOTE: This middleware should not be used in a threaded environment
#
# use Rack::Signals.new do
#   trap 'INT', lambda {
#     puts "Exiting now"
#     exit
#   }
#
#   trap_when_ready 'USR1', lambda {
#     puts "Exiting when ready"
#     exit
#   }
# end
#
# source://rack-contrib//lib/rack/contrib/signals.rb#19
class Rack::Signals
  # @return [Signals] a new instance of Signals
  #
  # source://rack-contrib//lib/rack/contrib/signals.rb#35
  def initialize(app, &block); end

  # source://rack-contrib//lib/rack/contrib/signals.rb#42
  def call(env); end

  # source://rack-contrib//lib/rack/contrib/signals.rb#58
  def trap_when_ready(signal, handler); end
end

# source://rack-contrib//lib/rack/contrib/signals.rb#20
class Rack::Signals::BodyWithCallback
  # @return [BodyWithCallback] a new instance of BodyWithCallback
  #
  # source://rack-contrib//lib/rack/contrib/signals.rb#21
  def initialize(body, callback); end

  # source://rack-contrib//lib/rack/contrib/signals.rb#30
  def close; end

  # source://rack-contrib//lib/rack/contrib/signals.rb#25
  def each(&block); end
end

# Create simple endpoints with routing rules, similar to Sinatra actions.
#
# Simplest example:
#
#   use Rack::SimpleEndpoint, '/ping_monitor' do
#     'pong'
#   end
#
# The value returned from the block will be written to the response body, so
# the above example will return "pong" when the request path is /ping_monitor.
#
# HTTP verb requirements can optionally be specified:
#
#   use Rack::SimpleEndpoint, '/foo' => :get do
#     'only GET requests will match'
#   end
#
#   use Rack::SimpleEndpoint, '/bar' => [:get, :post] do
#     'only GET and POST requests will match'
#   end
#
# Rack::Request and Rack::Response objects are yielded to block:
#
#   use Rack::SimpleEndpoint, '/json' do |req, res|
#     res['Content-Type'] = 'application/json'
#     %({"foo": "#{req[:foo]}"})
#   end
#
# When path is a Regexp, match data object is yielded as third argument to block
#
#   use Rack::SimpleEndpoint, %r{^/(john|paul|george|ringo)} do |req, res, match|
#     "Hello, #{match[1]}"
#   end
#
# A :pass symbol returned from block will not return a response; control will continue down the
# Rack stack:
#
#   use Rack::SimpleEndpoint, '/api_key' do |req, res|
#     req.env['myapp.user'].authorized? ? '12345' : :pass
#   end
#
#   # Unauthorized access to /api_key will be handled by PublicApp
#   run PublicApp
#
# source://rack-contrib//lib/rack/contrib/simple_endpoint.rb#47
class Rack::SimpleEndpoint
  # @return [SimpleEndpoint] a new instance of SimpleEndpoint
  #
  # source://rack-contrib//lib/rack/contrib/simple_endpoint.rb#48
  def initialize(app, arg, &block); end

  # source://rack-contrib//lib/rack/contrib/simple_endpoint.rb#55
  def call(env); end

  private

  # source://rack-contrib//lib/rack/contrib/simple_endpoint.rb#67
  def extract_path(arg); end

  # source://rack-contrib//lib/rack/contrib/simple_endpoint.rb#71
  def extract_verbs(arg); end

  # source://rack-contrib//lib/rack/contrib/simple_endpoint.rb#75
  def match_path(path); end

  # @return [Boolean]
  #
  # source://rack-contrib//lib/rack/contrib/simple_endpoint.rb#79
  def valid_method?(method); end
end

# source://rack-contrib//lib/rack/contrib/static_cache.rb#54
class Rack::StaticCache
  # @return [StaticCache] a new instance of StaticCache
  #
  # source://rack-contrib//lib/rack/contrib/static_cache.rb#56
  def initialize(app, options = T.unsafe(nil)); end

  # source://rack-contrib//lib/rack/contrib/static_cache.rb#79
  def call(env); end

  # source://rack-contrib//lib/rack/contrib/static_cache.rb#105
  def duration_in_seconds; end

  # source://rack-contrib//lib/rack/contrib/static_cache.rb#101
  def duration_in_words; end
end

# source://rack-contrib//lib/rack/contrib/time_zone.rb#4
class Rack::TimeZone
  # @return [TimeZone] a new instance of TimeZone
  #
  # source://rack-contrib//lib/rack/contrib/time_zone.rb#14
  def initialize(app); end

  # source://rack-contrib//lib/rack/contrib/time_zone.rb#18
  def call(env); end
end

# source://rack-contrib//lib/rack/contrib/time_zone.rb#5
Rack::TimeZone::Javascript = T.let(T.unsafe(nil), String)

# The Rack::TryStatic middleware delegates requests to Rack::Static middleware
# trying to match a static file
#
# Examples
#
# use Rack::TryStatic,
#   :root => "public",  # static files root dir
#   :urls => %w[/],     # match all requests
#   :try => ['.html', 'index.html', '/index.html'] # try these postfixes sequentially
#
#   uses same options as Rack::Static with extra :try option which is an array
#   of postfixes to find desired file
#
# source://rack-contrib//lib/rack/contrib/try_static.rb#18
class Rack::TryStatic
  # @return [TryStatic] a new instance of TryStatic
  #
  # source://rack-contrib//lib/rack/contrib/try_static.rb#20
  def initialize(app, options); end

  # source://rack-contrib//lib/rack/contrib/try_static.rb#28
  def call(env); end
end
