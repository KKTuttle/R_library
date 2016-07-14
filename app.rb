require('sinatra')
require('sinatra/reloader')
require('./lib/books')
require('./lib/patrons')
require('pg')
require('pry')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "library"})

get('/') do
  @books = Book.all()
  @patrons = Patron.all()
  erb(:index)
end

post('/books') do
  name = params['name']
  author = params['author']
  book = Book.new({:id => nil, :name => name, :author => author})
  book.save()
  @books = Book.all()
  @patrons = Patron.all()
  erb(:index)
end

get("/books/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @books = Book.all()
  @patrons = Patron.all()
  erb(:book_info)
end

get("/books/:id/edit") do
  @book = Book.find(params.fetch("id").to_i())
  @books = Book.all()
  @patrons = Patron.all()
  erb(:book_edit)
end

patch("/books/:id/edit") do
  name = params['name']
  author = params['author']
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:name => name, :author => author})
  @books = Book.all()
  @patrons = Patron.all()
  erb(:book_edit)
end

patch("/books/:id") do
  book_id = params.fetch("id").to_i()
  @book = Book.find(book_id)
  patron_ids = params.fetch("patron_ids")
  @book.add_user({:patron_ids => patron_ids})
  @books = Book.all()
  @patrons = Patron.all()
  erb(:book_info)
end

delete("/books/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @book.delete()
  @books = Book.all()
  @patrons = Patron.all()
  erb(:index)
end

get('/search') do
  name = params.fetch("search_name")
  author = params.fetch("search_author")
  @book = Book.search(name, author)
  @books = Book.all()
  @patrons = Patron.all()
  erb(:book_info)
end

post('/patrons') do
  name = params["user_name"]
  patron = Patron.new({id: nil, name: name})
  patron.save()
  @patrons = Patron.all()
  @books = Book.all()
  erb(:index)
end

get('/patrons/:id') do
  @patron = Patron.find(params["id"].to_i())
  @books = Book.all()
  erb(:patron)
end

patch('/patrons/:id/edit') do
  @patron = Patron.find(params.fetch("id").to_i())
  name = params['new_user_name']
  @patron.update({name: name})
  @books = Book.all()
  erb(:patron)
end

patch('/patrons/:id') do
  patron_id = params.fetch("id").to_i()
  @patron = Patron.find(params.fetch("id").to_i())
  book_ids = params.fetch("book_ids")
  @patron.add_book({:book_ids => book_ids})
  @books = Book.all()
  erb(:patron)
end

delete("/patrons/:id") do
  @patron = Patron.find(params.fetch("id").to_i())
  @patron.delete()
  @patrons = Patron.all()
  @books = Book.all()
  erb(:index)
end
