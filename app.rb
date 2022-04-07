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
    Booking.create(
      guest_id: session[:user_id], #placeholder for the user id stored in the session
      place_id: params[:id],
      check_in_date: params[:check_in],
      check_out_date: params[:check_out]
    )
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

  get '/users/myrequests' do
    @bookings = Booking.user_list(user_id: session[:user_id])
    erb :'users/myrequests'
  end

  run! if app_file == $0
end
