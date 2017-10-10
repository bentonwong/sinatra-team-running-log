ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  if development?
    set :database, {
      adapter: "sqlite3",
      database: "db/#{ENV['SINATRA_ENV']}.sqlite"
    }
  else
    set :database, ENV['DATABASE_URL']
end

require_all 'app'
