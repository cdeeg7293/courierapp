class Order < ActiveRecord::Base
  belongs_to :sender,   :class_name => Client
  belongs_to :receiver, :class_name => Client
  
  before_create :set_dates
  after_create :set_number
  
  def is_delivered?
    return self.delivered_date < DateTime.current
  end
  
  private
  
  def set_dates
    self.issued_date = DateTime.current
    self.delivered_date = Date.new(2099, 01, 01)
  end
  
  def set_number
    self.number = self.id + 1
    self.save
  end
end
