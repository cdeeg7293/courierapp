class Courier < ActiveRecord::Base
  after_initialize :create_associated_client, :if => :new_record?
  after_destroy :destroy_address_living
  
  belongs_to :client
  accepts_nested_attributes_for :client,  :reject_if => :all_blank, update_only: true

  belongs_to :address
  accepts_nested_attributes_for :address, :reject_if => :all_blank, update_only: true

private

  def create_associated_client
    self.build_client unless self.client
    self.build_address unless self.address
  end
  
  def destroy_address_living
    self.destroy_address if self.address
  end
end
