require('spec_helper')

describe(Book) do
  describe('.all') do
    it "will be first at the beginning" do
      expect(Book.all()).to(eq([]))
    end
  end

  describe("#==") do
    it "is the same book if it has the same info " do
      test_book = Book.new({:id => nil, :name => "Harry Potter", :author => "J.K.Rowling"})
      test_book2 = Book.new({:id => nil, :name => "Harry Potter", :author => "J.K.Rowling"})
      expect(test_book).to(eq(test_book2))
    end
  end

  describe("#save") do
    it "saves the book to the array of books" do
      test_book = Book.new({:id => nil, :name => "Harry Potter", :author => "J.K.Rowling"})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe(".find") do
    it "finds the book by id number" do
      test_book = Book.new({:id => nil, :name => "Harry Potter", :author => "J.K.Rowling"})
      test_book.save()
      expect(Book.find(test_book.id())).to(eq(test_book))
    end
  end

  describe("#update") do
    it "lets you update a name and an author" do
      book = Book.new({:id => nil, :name => "Harry Potter", :author => "J.K.Rowling"})
      book.save()
      book.update({:name => "Parry Hotter", :author => "K.J.Rowling"})
      expect(book.name()).to(eq("Parry Hotter"))
      expect(book.author()).to(eq("K.J.Rowling"))
    end
  end

  describe("#delete") do
    it "lets you you delete a book from the database" do
      book = Book.new({:id => nil, :name => "Harry Potter", :author => "J.K.Rowling"})
      book.save()
      book2 = Book.new({:id => nil, :name => "Parry Hotter", :author => "K.J.Rowling"})
      book2.save()
      book.delete()
      expect(Book.all()).to(eq([book2]))
    end
  end
end
