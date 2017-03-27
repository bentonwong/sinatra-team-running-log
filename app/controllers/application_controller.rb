require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'runners/create_runner'
  end

  post '/signup' do
    redirect to '/login'
  end

  get '/login' do
    erb :'runners/login'
  end


end
