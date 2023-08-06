require "uri"
require_relative "../lib/gopher/client"
RSpec.describe(Gopher) do
  describe "#get" do
    it "returns the correct gopher response for a known uri" do
      expect(Gopher.get("gopher://tilde.team:70/~ben/phlog/20180718-what-should-i-write-about-today.txt")
        .split("\r\n").compact[2]).to eq("July 18th, 2018")
    end
  end
end
