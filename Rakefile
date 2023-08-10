require "rake"
require "rspec/core/rake_task"
require "graphql/rake_task"
require_relative "graphql/types"
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

GraphQL::RakeTask.new(schema_name: "TwindexSchema")
namespace :graphql do
  task export: :environment do
    Rake::Task["graphql:schema:dump"].invoke
  end
end
