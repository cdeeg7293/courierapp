class Order < ActiveRecord::Base
  belongs_to :sender,   :class_name => Client
  belongs_to :receiver, :class_name => Client
end
