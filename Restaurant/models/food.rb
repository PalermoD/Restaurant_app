class Food < ActiveRecord::Base
    belongs_to(:party)
	has_many(:orders)
    has_many(:parties, :through => :orders)
end 