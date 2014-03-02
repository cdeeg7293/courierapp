class Address < ActiveRecord::Base
  has_one :client, inverse_of: :address
end
