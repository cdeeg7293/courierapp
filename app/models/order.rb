class Order < ActiveRecord::Base
  belongs_to :sender,   :class_name => Client
  belongs_to :receiver, :class_name => Client
  
  before_create :set_dates
  after_create :set_number
  
  validates :sender_id, :receiver_id, presence: true
  #taken from stackoverflow
  validates :sum, :format => { :with => /\A\d+??(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :less_than => 10}
  
  def is_delivered?
    return self.delivered_date < DateTime.current
  end
  
  private
  
  def set_dates
    self.issued_date = DateTime.current
    self.delivered_date = Date.new(2099, 01, 01)
  end
  
  def set_number
    self.number = self.id + 10000
    self.save
  end
end
