class Order < ActiveRecord::Base
  belongs_to :sender,   :class_name => Client
  belongs_to :receiver, :class_name => Client
  
  before_create :set_dates
  after_create :set_number
  
  validates :sender_id, :receiver_id, presence: true
  #taken from stackoverflow
  validates :sum, :format => { :with => /\A\d+??(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :less_than => 10}
  
  #scopes
  scope :by_issue_date, -> date_beg, date_end { where("issued_date >= ? AND issued_date <= ?", date_beg, date_end) }
  scope :by_delivery_date, -> date_beg, date_end { where("delivered_date >= ? AND delivered_date<= ?", date_beg, date_end) }
  scope :by_sender, -> sender_id { where("sender_id = ?", sender_id) }
  scope :by_receiver, -> receiver_id { where("receiver_id = ?", receiver_id) }
  scope :by_number, -> number { where("number = ?", number) }
  
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
