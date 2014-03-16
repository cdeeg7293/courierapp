class Client < ActiveRecord::Base
  after_initialize :create_associated, :if => :new_record?
  after_destroy :destroy_address

  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :contacts, :reject_if => :all_blank, allow_destroy: true

  belongs_to :address
  accepts_nested_attributes_for :address,  :reject_if => :all_blank, update_only: true
  
  has_many :sended_orders, :class_name => Order, :foreign_key => :sender_id
  has_many :received_orders, :class_name => Order, :foreign_key => :receiver_id
  
  validates :last_name, presence: true
  validates :first_name, :patronymic, presence: true, if: Proc.new { |client| client.is_person }
  
  validates :address, presence: true

  def full_name
    last_name + ' ' + first_name + ' ' + patronymic
  end

  private 

  def create_associated
    self.contacts.build if self.contacts.empty?
    self.build_address unless self.address
  end

  def destroy_address
    self.destroy_address if self.address
  end
end
