require 'matrix'
require 'coordinates'
require 'route'
require 'route_point'

class RouteFinder
  
  attr_reader :best_route
  
  def initialize(senders, receivers, origin_point)
    @senders = senders
    @receivers = receivers
    @origin_point = origin_point
    
    @best_route = Route.new
    @best_route.set_max_length
    
    buildDistanceMatrix
  end
  
  
  
  def find_best_route
    if @senders.length == 0 || @receivers.length == 0
      return []
    end
    
    @senders.each_with_index do |sender, sender_index|
      new_route = Route.new
      visited_places = []
      distance = distance(-1, sender_index) #-1 means origin_point
      new_route.add_waypoint(sender_index, distance)
      visited_places.push(sender_index)
      find_best_route_recursive(new_route, visited_places)
    end
    
    return buildCoordRoute
  end
  
  private
  
  def buildDistanceMatrix
    order_count = @senders.length
    if order_count != @receivers.length
      raise "Sender count is not equal to receiver count"
    end
    @distance_matrix = Array.new(order_count * 2){ Array.new(order_count * 2) { 0 }} #building a matrix of dimension twice of orders count (senders to senders, receivers to receivers) and initializing it with zeroes
    #senders to senders
    i = 0
    j = 0
    while i < order_count
      while j < order_count
	@distance_matrix[i][j] = distance_internal(@senders[i], @senders[j])
	j += 1
      end
      i += 1
    end
    #receivers to receivers
    i = 0
    j = 0
    while i < order_count
      while j < order_count
	@distance_matrix[i + order_count][j + order_count] = distance_internal(@receivers[i], @receivers[j])
	j += 1
      end
      i += 1
    end
    #senders to receivers
    i = 0
    j = 0
    while i < order_count
      while j < order_count
	@distance_matrix[i][j + order_count] = distance_internal(@senders[i], @receivers[j])
	j += 1
      end
      i += 1
    end
    #receivers to senders
    i = 0
    j = 0
    while i < order_count
      while j < order_count
	@distance_matrix[i + order_count][j] = distance_internal(@receivers[i], @senders[j])
	j += 1
      end
      i += 1
    end
    #senders to origin point, receivers to origin point
    @origin_distance_array = Array.new(order_count * 2) { 0 }
    i = 0
    while i < order_count * 2
      if i < order_count
	@origin_distance_array[i] = distance_internal(@origin_point, @senders[i])
      else
	@origin_distance_array[i] = distance_internal(@origin_point, @receivers[i - order_count])
      end
      i += 1
    end
    
  @order_count = order_count
end
    
  def distance_internal(start_coords, end_coords)
    #converting degrees to radians
    lat_start = start_coords.latitude * Math::PI / 180
    lng_start = start_coords.longitude * Math::PI / 180
    
    lat_end = end_coords.latitude * Math::PI / 180
    lng_end = end_coords.longitude * Math::PI / 180
    
    #calculating distance on a sphere using haversine formula
    return 2 * Math.asin(Math.sqrt((Math.sin((lat_end - lat_start) / 2) * Math.sin((lat_end - lat_start) / 2)) + Math.cos(lat_start) * Math.cos(lat_end) * (Math.sin((lng_end - lng_start) / 2) * Math.sin((lng_end - lng_start) / 2))))
  end
  
  def find_best_route_recursive(route, visited_places)
    
    if visited_places.length == @receivers.length * 2 
      length_to_add = distance(route.last_waypoint, -1)
      if route.length < @best_route.length
	@best_route = route.clone
      end
      return;
    end
    #ugly code rewritten from c#
    visited_senders = []
    visited_receivers = []
    visited_places.each { |place| place < @order_count ? visited_senders.push(place) : visited_receivers.push(place - @order_count) } #dividing visited places into senders and receivers 
    
    order_count = @senders.length
    #number_array = order_count.times.collect { |x| x - 1 }
    number_array = (0..order_count - 1).to_a #[0, 1, ..., order_count]
    non_visited_senders = number_array.select { |item| !visited_senders.include?(item) }
    non_visited_receivers = number_array.select { |item| !visited_receivers.include?(item) }
    
    possible_receivers = visited_senders & non_visited_receivers
    
    possible_waypoints = non_visited_senders.clone
    possible_receivers.each { |rec| possible_waypoints.push(rec + @order_count) }
    
    possible_waypoints.each do |pw|
      new_link_length = @distance_matrix[route.last_waypoint][pw]
      
      if (new_link_length + route.length) > @best_route.length
	return
      end
      
      new_route = route.clone
      new_route.add_waypoint(pw, new_link_length)
      
      new_visited_places = visited_places.clone
      new_visited_places.push(pw)
          
      find_best_route_recursive(new_route, new_visited_places)
      new_route.remove_last_waypoint
    end
  end
  
  def distance(start_number, end_number)
    if start_number < 0 
      return @origin_distance_array[end_number]
    elsif end_number < 0 
      return @origin_distance_array[start_number]
    else
      return @distance_matrix[start_number][end_number]
    end
  end
  
  def buildCoordRoute
    coord_route = []
    best_route.each do |route_point| 
      if (route_point < @senders.length)
	coord_route.push(@senders[route_point])
      else
	coord_route.push(@receivers[route_point - @senders.length])
      end
    end
    return coord_route
  end
end
