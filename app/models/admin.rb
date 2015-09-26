class Admin < ActiveRecord::Base
	validates :email, :email_format => { :message => "The email address is not valid or in the wrong format" }
	validates_uniqueness_of :email
	validates :name, presence: true
	validates :password, length: { in: 6..20 }
	before_destroy :destroyable?
  	def destroyable?
    	name != "admin"
  	end
end
