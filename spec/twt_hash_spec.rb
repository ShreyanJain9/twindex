# typed: false
require_relative "../lib/twt_hash"
describe(TwtHash) do
  it "generates a yarn-compliant hash" do
    url = "https://twtxt.net/user/shreyan/twtxt.txt"
    timestamp = "2023-08-01T04:51:05Z"
    content = "(#xdfwwgq) @<stigatle https://yarn.stigatle.no/user/stigatle/twtxt.txt> happy birthday 🎂"
    expected_hash = "cyw3xta"
    actual_hash = TwtHash.twt_hash(url, timestamp, content)
    expect(actual_hash).to eq(expected_hash)
  end
end
