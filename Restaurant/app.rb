require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
	:adapter => "postgresql",
	:database => "restaurant_db"
);        

ROOT_PATH = Dir.pwd
Dir[ROOT_PATH+"/models/*.rb"].each{ |file| require file }



get '/' do 
	"welcome to the best FU#KING restarant app EVER!!!"
end 

get '/foods' do 
   @foods = Food.all 
   erb :'foods/index'  
end 


get '/foods/new' do 
   erb :'foods/new' 
end 

post '/foods' do 
	new_cusine = params['cusine_name']
	new_price = params['cusine_price']
	new_allergens = params['cusine_allergens']
	Food.create({cusine_type: new_cusine, price: new_price, allergens: new_allergens })
	redirect '/foods'
end 

get '/foods/:id' do 
	@foods = Food.find(params[:id])
	erb :'foods/show'  
end 

get '/foods/:id/edit' do 
	@foods = Food.find(params[:id])
	erb :'foods/edit' 
end 

patch '/foods/:id' do 
	food = Food.find(params[:id])
	new_cusine = params['cusine_name']
	profile.update({cusine_type: new_cusine})
	redirect '/foods'
end 

delete '/foods/:id' do 
	food = Food.find(params[:id])
	food.destroy 
	redirect '/foods'
end 


#Party time 
get '/parties' do 
   @parties = Party.all 
   erb :'parties/index'  
end 


get '/parties/new' do 
   erb :'parties/new' 
end 

post '/parties' do 
	new_table = params['table_number']
	new_guest = params['guest_number']
	paid = params['paid']
	Party.create({table_number: new_table, guest_number: new_guest, paid: paid })
	redirect '/parties'
end 

get '/parties/:id' do 
	@parties = Party.find(params[:id])
	erb :'parties/show'  
end 

get '/parties/:id/edit' do 
	@parties = Party.find(params[:id])
	erb :'parties/edit' 
end 

patch '/parties/:id' do 
	party = Party.find(params[:id])
	new_cusine = params['cusine_name']
	profile.update({cusine_type: new_cusine})
	redirect '/parties'
end 

delete '/parties/:id' do 
	party = Party.find(params[:id])
	party.destroy 
	redirect '/parties'
end 



