# typed: false
require_relative "../lib/extensions"
require_relative "../lib/twt_hash/hash"
describe(TwtHash) do
  it "generates a yarn-compliant hash" do
    let :url {"https://twtxt.net/user/shreyan/twtxt.txt"}
    let :timestamp { "2023-08-01T04:51:05Z" }
    let :content {"(#xdfwwgq) @<stigatle https://yarn.stigatle.no/user/stigatle/twtxt.txt> happy birthday 🎂"}
    let :expected_hash { "cyw3xta" }
    let :actual_hash { TwtHash.twt_hash(url, timestamp, content) }
    expect(actual_hash).to eq(expected_hash)
  end
end
