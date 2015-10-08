json.array!(@book_transactions) do |book_transaction|
  json.extract! book_transaction, :id, :isbn, :name, :member
  json.url book_transaction_url(book_transaction, format: :json)
end