require_relative "app"

load_models()
Feed.all.each(&:process)
