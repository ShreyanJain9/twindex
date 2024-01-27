# typed: false
require_relative "../lib/extensions"
require_relative "../lib/twt_hash/hash"
describe(TwtHash) {
  let :url do "https://twtxt.net/user/shreyan/twtxt.txt" end
  let :timestamp do "2023-08-01T04:51:05Z" end
  let :content do "(#xdfwwgq) @<stigatle https://yarn.stigatle.no/user/stigatle/twtxt.txt> happy birthday 🎂" end
  let :expected_hash do "cyw3xta" end
  let :actual_hash do TwtHash.twt_hash(url, timestamp, content) end
  it "generates a yarn-compliant hash" do
    expect(actual_hash).to eq(expected_hash)
  end
}
