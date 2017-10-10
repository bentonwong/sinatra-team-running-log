ENV['SINATRA_ENV'] ||= "development"
ENV['DATABASE_URL'] = kgydaitjdbxgrk:349710f64d899a88bc92f2ca0ef2c7d5a9a1cb8baa60388accab731a81fe2cbf@ec2-184-72-245-58.compute-1.
amazonaws.com:5432/ddcd6tfcn01d8r


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
