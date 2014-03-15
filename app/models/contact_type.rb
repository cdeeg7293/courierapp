class ContactType < ActiveRecord::Base
  has_one :contact
  validates :type_name, presence: true
end
