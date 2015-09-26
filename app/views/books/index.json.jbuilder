json.array!(@books) do |book|
  json.extract! book, :isbn, :name, :authors
  json.url book_url(book, format: :json)
end
