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
    @places = Place.all
    erb :'places/list'
  end

   get '/places/:id/request' do
    @place = Place.find(id: params[:id])
    erb :'places/request'
  end

  post '/places/:id/confirmation' do
    @place = Place.find(id: params[:id])
    @customer = params[:customer_name]
   
    #Notifier.send_email
    # (
    #   customer_name: params[:customer_name],
    #   customer_email: params[:customer_email],
    #   check_in: params[:check_in],
    #   check_out: params[:check_out],
    #   comments: params[:comments_box]
    # )
    erb :'places/confirmation'
  end
  
  get '/places/add' do 
    erb :"places/add"
  end

  post '/places/list' do
    Place.create(
      host_name: params[:host_name],
      host_email: params[:host_email],
      place_title: params[:place_title],
      place_price: params[:place_price],
      location: params[:location],
      description: params[:description],
      available_from: params[:available_from],
      available_until: params[:available_until]
    )
    redirect('/places/list')
  end

  get '/users/register' do
    erb :"users/register"
  end

  post '/users/register' do
    if params[:password] != params[:confirm_password]
      'Error: passwords do not match'
    else
      User.create(
        user_first_name: params[:user_first_name],
        user_surname: params[:user_surname],
        user_email: params[:user_email],
        user_password: params[:user_password],
        mobile_number: params[:mobile_number],
      )
    end
  end

  run! if app_file == $0
end
