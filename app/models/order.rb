class Order < ActiveRecord::Base
  belongs_to :sender,   :class_name => Client
  belongs_to :receiver, :class_name => Client
  
  before_create :set_issue_date
  after_create :set_number
  
  private
  
  def set_issue_date
    self.issued_date = DateTime.current
  end
  
  def set_number
    self.number = self.id + 1
    self.save
  end
end
