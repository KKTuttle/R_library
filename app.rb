require('sinatra')
require('sinatra/reloader')
require('./lib/books')
require('./lib/checkouts')
require('./lib/patrons')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "library"})

get('/') do
  @books = Book.all()
  erb(:index)
end

post('/') do
  name = params['name']
  author = params['author']
  @book = Book.new({:id => nil, :name => name, :author => author})
  @book.save()
  @books = Book.all()
  erb(:index)
end

get("/books/:id/edit") do
  @book = Book.find(params.fetch("id").to_i())
  erb(:book_edit)
end
#
patch("/books/:id") do
  name = params['name']
  author = params['author']
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:name => name, :author => author})
  @books = Book.all()
  erb(:index)
end

delete("/books/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @book.delete()
  @books = Book.all()
  erb(:index)
end
