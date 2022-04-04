require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnB < Sinatra::Base

  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/test' do
    'Testing testing'
  end

  run! if app_file == $0
end
