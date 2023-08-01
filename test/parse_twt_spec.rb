require_relative "../lib/twt_parser"
require "rspec/autorun"

$twt = "(#xdfwwgq) @<stigatle https://yarn.stigatle.no/user/stigatle/twtxt.txt> @<shreyan https://shreyanjain.net/twtxt> happy birthday 🎂"
$parsed_twt = TwtParser.parse_twt($twt)

describe(TwtParser) do
  describe("parse_twt") do
    it("successfully finds all mentions") do
      expect(
        $parsed_twt[:mentions]
      ).to eq(
        [
          { name: "stigatle", url: "https://yarn.stigatle.no/user/stigatle/twtxt.txt" },
          { name: "shreyan", url: "https://shreyanjain.net/twtxt" },
        ]
      )
    end
    it("successfully finds the reply hash") do
      expect($parsed_twt[:reply_to]).to eq("xdfwwgq")
    end
    it("successfully finds the content") do
      expect($parsed_twt[:content]).to eq("happy birthday 🎂")
    end
  end
end
