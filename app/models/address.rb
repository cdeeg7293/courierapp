class Address < ActiveRecord::Base
  has_one :client, inverse_of: :address
  
  def full_address
    city + ' ' + street + ' ' + building + ' ' + apartment.to_s
  end
end
