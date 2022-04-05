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

  get '/' do
    redirect '/places/list'
  end

  get '/places/list' do
    erb :list
  end

  get '/places/request' do
    @place = Place.new(id: params[:id])
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
  
  get '/places/add' do 
    erb :"places/add"
  end

  post '/places' do
    Place.create(
      host_name: params[:host_name],
      host_email: params[:host_email],
      place_title: params[:place_title],
      place_price: params[:place_price],
      location: params[:location],
      description: params[:description]
    )
    redirect('/places')
  end

  run! if app_file == $0
end
