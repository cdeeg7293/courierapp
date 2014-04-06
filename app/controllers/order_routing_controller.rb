require 'coordinates'
require 'route_finder'

class OrderRoutingController < ApplicationController
  def index
    @orders = Order.where("delivered_date >= ?", DateTime.current)
    
    @senders_coords = []
    @receivers_coords = []
    
    @orders.each do |order|
      sender_address = order.sender.address
      sender_coords = Coordinates.new(sender_address.latitude, sender_address.longitude)
      @senders_coords.push(sender_coords)
      
      receiver_address = order.receiver.address
      receiver_coords = Coordinates.new(receiver_address.latitude, receiver_address.longitude)
      @receivers_coords.push(receiver_coords)
    end
    
    @op = Coordinates.new(48.01, 37.768)
    
    router = RouteFinder.new(@senders_coords, @receivers_coords, @op)
    
    @best_route = router.find_best_route
    
  end

  def route_orders
  end
end
