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

#Display a list of food items available
get '/foods' do 
   @foods = Food.all 
   erb :'foods/index'  
end 

#Display a form for a new food item
get '/foods/new' do 
   erb :'foods/new' 
end 

#Creates a new food item
post '/foods' do 
	new_order = params['food_order']
	new_name = params['name']
	new_cusine = params['cusine_type']
	new_price = params['cusine_price']
	new_allergens = params['cusine_allergens']
	Food.create({food_order: new_order, name: new_name, cusine_type: new_cusine, price: new_price, allergens: new_allergens })
	redirect '/foods'
end 

#Display a single food item and a list of all the parties that included it
get '/foods/:id' do 
	@foods = Food.find(params[:id])
	erb :'foods/show'  
end 

#Display a form to edit a food item
get '/foods/:id/edit' do 
	@foods = Food.find(params[:id])
	erb :'foods/edit' 
end 

#Updates a food item
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

#Deletes a food item
delete '/foods/:id' do 
	food = Food.find(params[:id])
	food.destroy 
	redirect '/foods'
end 


#Party time 


#display a list of the parties 
get '/parties' do 
   @parties = Party.all 
   erb :'parties/index'  
end 

#Display a form for a new party
get '/parties/new' do 
   erb :'parties/new' 
end 
#Creates a new party
post '/parties' do 
	new_party_order = params['table_order']
	new_table = params['table_number']
	new_guest = params['guest_number']
	paid = params['paid']
	Party.create({table_order: new_party_order, table_number: new_table, guest_number: new_guest, paid: paid })
	redirect '/parties'
end 
#Display a single party and options for adding a food item to the party
get '/parties/:party_id' do 
	@party = Party.find(params[:party_id])
    @orders = @party.orders
    @food = Food.find(params[:party_id])
	erb :'parties/show'
end 

#Display a form for to edit a party's details
get '/parties/:id/edit' do 
	@parties = Party.find(params[:id])

	erb :'parties/edit' 
end 

#Updates a party's details
patch '/parties/:id' do 
	party = Party.find(params[:id])
	new_id = params['party_id']
	new_table = params['table_number']
	new_guest = params['guest_number']
	paid = params['paid']
	party.update({id: new_id, table_number: new_table, guest_number: new_guest, paid: paid })
	redirect '/parties'
end 

#Delete a party
delete '/parties/:id' do 
	party = Party.find(params[:id])
	party.destroy 
	redirect '/parties'
end 


get '/orders' do 
   @orders = Order.all 
   erb :'orders/index'  
end 


get '/orders/new' do 
	@parties = Party.all 
	@foods = Food.all  
   erb :'orders/new' 
end 

post '/orders' do 
	new_food_id = params['food_id']
	new_party_id = params['party_id']
	new_order = params['order_id']
	Order.create({ party_id: new_party_id, food_id: new_food_id})
	redirect '/orders'
end 

get '/orders/:id' do 
	@order = Order.find(params[:id])
	@food = Food.find(params[:id])
	@party = Party.find(params[:id])
	erb :'orders/show'  
end 

get '/orders/:id/edit' do 
	@order = Order.find(params[:id])
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
	@party = Party.find(params[:id])
	@orders = @party.orders
	foods = @party.foods
	sum = foods.map{|food| food.price}.inject{ |sum, price| sum += price }
	
	 @receipt = File.open('receipt.txt', 'w', ) do |f|
       @orders.each do |order|
       	f.puts(order.food.name + " " + order.food.price.to_s) 
       end 
       f.puts(sum)
    end 
    attachment "receipt.txt"
   
    send_file 'receipt.txt'
    erb :'parties/receipt'
 end 

























