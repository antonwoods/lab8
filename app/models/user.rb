class User < ActiveRecord::Base
  attr_accessible :name, :email # tells Ruby which properties can be edited from outside
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  
  validates( :name, :presence => true,
                    :length => {:maximum => 50 } )  #validate that name is present
  validates( :email, :presence => true,
                     :format => {:with => email_regex },
                     :uniqueness => { :case_sensitive => false})   #validates that the email is present


end
