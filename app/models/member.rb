class Member < ActiveRecord::Base
	validates :email, :email_format => { :message => "The email address is not valid or in the wrong format" }
	validates_uniqueness_of :email
	validates :name, presence: true
	validates :password, length: { in: 6..20 }

	has_many :book_transactions
	has_many :books, through: :book_transactions
	before_destroy :active_checkouts?
	def checked_out_books
		checked_out_books = []
		books = BookTransaction.where(member_id:id).map{|x| x.book}
		books.uniq.each do |book|
			if(books.count(book).odd?)
				checked_out_books << book
			end
		end
		checked_out_books
	end
	def active_checkouts?
		checked_out_books.empty?
	end
end
