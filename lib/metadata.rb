def extract_metadata(input_string)
  input_string.split("\n")
              .map(&:strip)
              .select { |line| line.start_with?("#") && !line.empty? }
              .map { |line| line.sub(/^#\s*/, "") }
              .partition { |line| line.start_with?("follow") }
              .then { |follow_lines, meta_lines|
    {
                  "follow" => follow_lines.map { |line|
                    line.match(/^follow\s*=\s*(\S+)\s+(.+)/)&.captures&.then { |username, url|
                      { username: username, url: url }
                    }
                  }.compact,
                  **meta_lines.map { |line|
                    line.match(/^(\S+)\s*=\s*(.+)/)&.captures&.then { |key, value|
                      { key => value }
                    }
                  }.compact.reduce({}, :merge),
                }.reject { |_, v| v.nil? || v.empty? }
  }
end
