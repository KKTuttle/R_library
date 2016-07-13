require('sinatra')
require('sinatra/reloader')
require('./lib/books')
require('./lib/checkouts')
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

post('/') do
  name = params['name']
  author = params['author']
  @patrons = Patron.all()
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
  @patrons = Patron.all()
  erb(:index)
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
  erb(:book_edit)
end

post('/patrons') do
  name =params["user_name"]
  @patron = Patron.new({id: nil, name: name})
  @patron.save()
  @patrons = Patron.all()
  @books = Book.all()
  erb(:index)
end

get('/patrons/:id') do
  @patron = Patron.find(params['id'].to_i())
  erb(:patron)
end

patch('/patrons/:id/edit') do
  name = params['new_user_name']
  @patron = Patron.find(params.fetch("id").to_i())
  @patron.update({name: name})
  @patrons = Patron.all()
  erb(:patron)

end
