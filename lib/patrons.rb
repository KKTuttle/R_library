class Patron
  attr_reader(:id, :name)
  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      id = patron["id"].to_i()
      name = patron["name"]
      patrons.push(Patron.new({:id => id, :name => name}))
    end
    patrons
  end

  define_method(:==) do |another_patron|
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id");
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_patron = nil
    Patron.all().each() do |patron|
      if patron.id().==(id)
        found_patron = patron
      end
    end
    found_patron
  end

  define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id  = #{@id};")
  end

  define_method(:add_book) do |attributes|
    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO checkouts (book_id, patron_id) VALUES (#{book_id}, #{self.id()});")
    end
  end

  define_method(:books) do
    checkouts = []
    results = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM  books WHERE id = #{book_id};")
      name = book.first().fetch("name")
      author = book.first().fetch("author")
      checkouts.push(Book.new({:id => book_id, :name =>name, :author => author}))
    end
    checkouts
  end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE patron_id = #{self.id()};")
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end
end
