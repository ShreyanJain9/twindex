require "sequel"

DB = Sequel.sqlite(File.expand_path("./twindex.db", __dir__))

def setup
  ->() do
    DB.create_table?(:twts) do
      primary_key :id
      DateTime :created_at
      String :content
      String :original
      String :reply_to
      String :hash, unique: true
      foreign_key :feed_id, :feeds
    end
    DB.create_table? :feeds do
      primary_key :id
      String :nick
      String :url, unique: true
      String :avatar
      DateTime :synced_at
    end

    DB.create_table? :mentions do
      primary_key :id
      foreign_key :feed_id, :feeds
      foreign_key :twt_id, :twts
    end
    DB.create_table? :follows do
      primary_key :id
      foreign_key :follower_id, :feeds
      foreign_key :following_id, :feeds
    end
  end
end

def load_models
  require_relative "models/twt.rb"
end
