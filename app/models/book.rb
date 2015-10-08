class Book < ActiveRecord::Base
  validates :isbn, uniqueness: true
  validates :isbn, numericality: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :authors, presence: true, length: { maximum: 100 }
  validates :authors, format: { :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/ }
  has_many :book_transactions
  has_many :ordered_members, -> { order(id: :asc) }, through: :book_transactions, source: :members
  has_many :subscribers
  has_many :members, through: :subscribers
  before_destroy :available?
  def list_of_owners
    members = BookTransaction.where(book_id:id).map{|x| x.member}
  end
  def current_owner
    members = BookTransaction.where(book_id:id).map{|x| x.member}
    if( members.count.odd? )
      current_owner = members.last
    else
      nil
    end
  end
  def available?
    current_owner.nil?
  end
end