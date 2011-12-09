class Response < ActiveRecord::Base
  belongs_to :user, :class_name => "User"
  
  
  attr_accessible :responseid, :voice
  
end
