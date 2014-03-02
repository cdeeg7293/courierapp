class Client < ActiveRecord::Base
  has_many :contacts
  accepts_nested_attributes_for :contacts, :reject_if => :all_blank, allow_destroy: true

  belongs_to :address
  accepts_nested_attributes_for :address, :reject_if => :all_blank, update_only: true

  def full_name
    last_name + ' ' + first_name + ' ' + patronymic
  end

  after_initialize :create_associated, :if => :new_record?

  private 

  def create_associated
    self.contacts.build if self.contacts.empty?
    self.build_address unless self.address
  end
end
