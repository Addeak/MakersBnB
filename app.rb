require 'sinatra/base'
require 'sinatra/reloader'
require './database_connection_setup'
require './lib/place'


class MakersBnB < Sinatra::Base

  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/places/:id/request' do
    @place = DatabaseConnection.query("SELECT * FROM places WHERE id = $1;", [params[:id]])
    erb :'places/request'
  end

  post '/places/confirmation' do
    @customer = params[:customer_name]
    Request.send_email(
      customer_name: params[:customer_name],
      customer_email: params[:customer_email],
      check_in: params[:check_in],
      check_out: params[:check_out],
      comments: params[:comments_box]
    )
    erb :'places/confirmation'
  end

  run! if app_file == $0
end
