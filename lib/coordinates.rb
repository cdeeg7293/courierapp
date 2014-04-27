class Coordinates
  
  attr_accessor :latitude, :longitude
  
  def initialize(lat, lng)
    @latitude = lat
    @longitude = lng
  end
  
  def to_a
    arr = Array.new
    arr << @latitude << @longitude
    return arr
  end
  
end
