module Twindex
  using Twindex::Extensions
  def self.extract_metadata(input_string)
    input_string.split("\n")
                .map(&:strip)
                .select { |line| line.start_with?("#") && !line.empty? }
                .map { |line| line.sub(/^#\s*/, "") }
                .partition { |line| line.start_with?("follow") }
                .then { |follow_lines, meta_lines|
      { # TODO bio links handled same as follow
        :follow => follow_lines.map { |line|
          line.match(/^follow\s*=\s*(\S+)\s+(.+)/)&.captures&.then { |username, url|
            { username: username, url: url }
          }
        }.compact,
        **meta_lines.map { |line|
          line.match(/^(\S+)\s*=\s*(.+)/)&.captures&.then { |key, value|
            { key.to_sym => value }
          }
        }.compact.reduce({}, :merge),
      }.reject_empty
    }
  end
end
