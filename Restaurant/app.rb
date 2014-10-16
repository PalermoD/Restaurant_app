require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
	:adapter => "postgresql",
	:database => "restaurant_db"
);        

ROOT_PATH = Dir.pwd
Dir[ROOT_PATH+"/models/*.rb"].each{ |file| require file }



get '/' do 
	
	@parties = Party.all 
	erb :index 
end 

get '/foods' do 
   @foods = Food.all 
   erb :'foods/index'  
end 


get '/foods/new' do 
   erb :'foods/new' 
end 

post '/foods' do 
	new_id = params['food_id']
	new_name = params['name']
	new_cusine = params['cusine_type']
	new_price = params['cusine_price']
	new_allergens = params['cusine_allergens']
	Food.create({id: new_id, name: new_name, cusine_type: new_cusine, price: new_price, allergens: new_allergens })
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
	new_id = params['food_id']
	new_name = params['name']
	new_cusine = params['cusine_type']
	new_price = params['cusine_price']
	new_allergens = params['cusine_allergens']
	food.update({id: new_id, name: new_name, cusine_type: new_cusine, price: new_price, allergens: new_allergens })
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
	new_id = params['party_id']
	new_table = params['table_number']
	new_guest = params['guest_number']
	paid = params['paid']
	party.update({id: new_id, table_number: new_table, guest_number: new_guest, paid: paid })
	redirect '/parties'
end 

delete '/parties/:id' do 
	party = Party.find(params[:id])
	party.destroy 
	redirect '/parties'
end 


#orders
get '/orders' do 
   @orders = Order.all 
   erb :'orders/index'  
end 


get '/orders/new' do 
   erb :'orders/new' 
end 

post '/orders' do 
	new_order = params['order_id']
	Order.create({id: new_order})
	redirect '/orders'
end 

get '/orders/:id' do 
	@orders = Order.find(params[:id])
	@parties = Party.find(params[:id])
	@foods = Food.find(params[:id])
	erb :'orders/show'  
end 

get '/orders/:id/edit' do 
	@orders = Order.find(params[:id])
	erb :'orders/edit' 
end 

patch '/orders/:id' do 
	order = Order.find(params[:id])
	new_cusine = params['cusine_name']
	order.update({cusine_type: new_cusine})
	redirect '/orders'
end 

delete '/orders/:id' do 
	order = Order.find(params[:id])
	order.destroy 
	redirect '/orders'
end 

#reciept shit 
get '/parties/:id/receipt' do
	@orders = Order.find(params[:id])
	@parties = Party.find(params[:id])
	@foods = Food.find(params[:id])
	 @receipt = File.open('receipt.txt', 'w') do |f|
      f.write @foods.name
      
      
      
     attachment "receipt.txt"
    end 
    send_file 'receipt.txt'
    erb :'parties/reciept'
   
end 







