require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
	:adapter => "postgresql",
	:database => "restaurant_db"
);        


require_relative 'models/food'

get '/' do 
	"welcome to the best FU#KING restarant app EVER!!!"
end 

get '/foods' do 
   @foods = Food.all 
   erb :index 
end 


get '/foods/new' do 
   erb :new 
end 

post '/foods' do 
	new_cusine = params['cusine_name']
	new_price = params['cusine_price']
	new_allergens = params['cusine_allergens']
	Food.create({cusine_type: new_cusine, price: new_price, allergens: new_allergens })
	redirect '/profiles'
end 

get '/foods/:id' do 
	@foods = Food.find(params[:id])
	erb :show  
end 

get '/foods/:id/edit' do 
	@foods = Food.find(params[:id])
	erb :edit 
end 

patch '/foods/:id' do 
	food = Food.find(params[:id])
	new_cusine = params['cusine_name']
	profile.update({cusine_type: new_cusine})
	redirect '/foods'
end 

delete '/profiles/:id' do 
	food = Food.find(params[:id])
	food.destroy 
	redirect '/foods'
end 