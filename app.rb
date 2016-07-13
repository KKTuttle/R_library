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
