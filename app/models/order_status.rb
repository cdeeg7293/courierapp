class OrderStatus < ActiveRecord::Base
  belongs_to :order
  belongs_to :courier
  
  validates :order, :courier, :date_planned, presence: true
end
