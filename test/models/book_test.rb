require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test "should not save book with missing info" do
    book = Book.new
    assert_not book.save
  end

  test "should not save book if ISBN already exists" do
    book = Book.new
    book.isbn = "1"
    book.name = "Test Book"
    book.authors = "Test Author"
    assert_not book.save
  end

  test "book shouldn't be available after checkout" do
    book = Book.find_by_isbn "1"
    book.check_out
    assert book.checked_out?
  end

  test "book is available after check out and return" do
    book = Book.find_by_isbn "3"
    book.check_out
    assert book.checked_out?
    book.return
    assert_not checked_out?
  end

end
