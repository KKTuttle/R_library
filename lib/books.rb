class Book
  attr_reader(:id, :name, :author)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @author = attributes[:author]
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      id = book["id"].to_i()
      name = book["name"]
      author = book["author"]
      books.push(Book.new({:id => id, :name => name, :author => author}))
    end
    books
  end

  define_method(:==) do |another_book|
    self.name().==(another_book.name()).&(self.id().==(another_book.id())).&(self.author().==(another_book.author()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (name, author) VALUES ('#{@name}', '#{@author}') RETURNING id");
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end

  define_singleton_method(:search) do |name, author|
    books = DB.exec("SELECT * FROM books WHERE name = '#{name}' OR author = '#{author}';").first
    id = books['id'].to_i
    name = books['name']
    author = books['author']
    returned_book = Book.new({name: name, author: author, id: id})
  end


  define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes[:name]
    @author = attributes[:author]
    DB.exec("UPDATE books SET name = '#{@name}', author = '#{@author}' WHERE id = #{@id};")
  end

  define_method(:add_user)  do |attributes|
    attributes.fetch(:patron_ids, []).each() do |patron_id|
      DB.exec("INSERT INTO checkouts (book_id, patron_id) VALUES (#{self.id()}, #{patron_id});")
    end
  end

  define_method(:patrons) do
    checkouts = []
    results = DB.exec("SELECT patron_id FROM checkouts WHERE book_id = #{self.id()};")
    results.each() do |result|
      patron_id = result.fetch("patron_id").to_i()
      patron = DB.exec("SELECT * FROM patrons WHERE id = #{patron_id};")
      name = patron.first().fetch("name")
      checkouts.push(Patron.new({:id => patron_id, :name =>name}))
    end
    checkouts
  end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE book_id = #{self.id()};")
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end
end
