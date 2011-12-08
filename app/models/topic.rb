class Topic < ActiveRecord::Base
  attr_accessible :title, :isactive, :cbuser
  
  belongs_to :user
  
  
  validates :title, :presence => true, :length => { :maximum => 50 }
  validates :cbuser, :presence => true
  validates :isactive, :presence => true
  
  
  default_scope :order => 'topics.created_at DESC'
  end
