require "rake"
require "rspec/core/rake_task"
require_relative "app"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob("spec/**/*_spec.rb")
  t.rspec_opts = "--format documentation"
end
task :default => :spec

namespace(:db) do
  task(:setup) do
    `make database`
  end
end

namespace(:feed) do
  task(:process, :feed_id) do |t, args|
    Feed[args[:feed_id]].process
  end
  task(:sync_new) do
    sync_new_feeds()
  end
end
