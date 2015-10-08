
class BookTransaction < ActiveRecord::Base
  validates :member_id ,presence: true,numericality: true
  validates :book_id ,presence: true , numericality: true
  belongs_to :member
  belongs_to :book
end