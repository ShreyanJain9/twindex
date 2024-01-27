# spec/metadata_spec.rb

require_relative "../lib/extensions"
require_relative "../lib/metadata"

RSpec.describe "#extract_metadata" do
  context "when input_string contains valid metadata" do
    let(:input_string) do
      <<~INPUT_STRING
        # nick = somenickname
        # description = Sample Description
        # follow = user1 https://example.com/user1
        # follow = user2 https://example.com/user2
        # follow = user3 https://example.com/user3
      INPUT_STRING
    end
    let :expected_result do {
      :nick => "somenickname",
      :description => "Sample Description",
      :follow => [
        { username: "user1", url: "https://example.com/user1" },
        { username: "user2", url: "https://example.com/user2" },
        { username: "user3", url: "https://example.com/user3" },
      ],
    }     end
    it "returns the correct metadata hash" do
      expect(Twindex.extract_metadata(input_string)).to eq(expected_result)
    end
  end

  context "when input_string contains invalid metadata" do
    let(:input_string) do
      <<~INPUT_STRING
        # nick = somenickname
        # description = Sample Description
        # invalid_metadata
        # follow = user1
      INPUT_STRING
    end

    it "skips invalid lines and returns the correct metadata hash" do
      expected_result = {
        :nick => "somenickname",
        :description => "Sample Description",
      }

      expect(Twindex.extract_metadata(input_string)).to eq(expected_result)
    end
  end

  context "when input_string is empty" do
    let(:input_string) { "" }

    it "returns an empty metadata hash" do
      expect(Twindex.extract_metadata(input_string)).to eq({})
    end
  end
end
