class Idea < ActiveRecord::Base
  attr_accessible :title, :isactive
  
    belongs_to :user
    
    
  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
    default_scope :order => 'ideas.created_at DESC'


end
