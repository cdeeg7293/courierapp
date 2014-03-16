class Address < ActiveRecord::Base
  has_one :client, inverse_of: :address
  
  validates :city, :street, :building, presence: true
  validates :apartment, numericality: { only_integer: true }
  
  geocoded_by :full_address  
  after_validation :geocode, if: ->(obj){ obj.changed? }          # auto-fetch coordinates
  
  def full_address
    city + ' ' + street + ' ' + building + ' ' + apartment.to_s
  end
end
