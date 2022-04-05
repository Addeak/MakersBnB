require 'sinatra/base'
require 'sinatra/reloader'
require './database_connection_setup'
require 'place'


class MakersBnB < Sinatra::Base

  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/test' do
    'Testing testing'
  end

  get '/' do
    redirect '/places/list'
  end

  get '/places/list' do
    erb :list
  end

  run! if app_file == $0
end
