require 'sinatra/base'
require 'sinatra/reloader'
require './database_connection_setup'
require_relative './lib/place'


class MakersBnB < Sinatra::Base

  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/test' do
    'Testing testing'
  end

  get '/places/add' do 
    erb :"places/add"
  end

  run! if app_file == $0
end
