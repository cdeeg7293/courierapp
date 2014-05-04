class OrderStatus < ActiveRecord::Base
  belongs_to :order
  belongs_to :courier
end
