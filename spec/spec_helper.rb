require 'rspec'
require 'pg'
require 'books'
require 'patrons'
require 'checkouts'

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    # DB.exec("DELETE FROM authors *;")
    # DB.exec("DELETE FROM checkouts *;")
  end
end
