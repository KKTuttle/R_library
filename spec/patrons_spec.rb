require('spec_helper')

describe(Patron) do
  describe(".all") do
    it "will be empty at the beginning" do
      expect(Patron.all()).to(eq([]))
    end
  end
  describe("#==") do
    it "is the same patron if they have the same info" do
      test_patron = Patron.new({:id => nil, :name => "Bob"})
      test_patron2 = Patron.new({:id => nil, :name => "Bob"})
      expect(test_patron).to(eq(test_patron2))
    end
  end

  describe("#save") do
    it "saves a patron to the array of patrons" do
      test_patron = Patron.new({:id => nil, :name => "Bob"})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe(".find") do
    it "returns a patron by id number" do
      test_patron = Patron.new({:id => nil, :name => "Bob"})
      test_patron.save()
      test_patron2 = Patron.new({:id => nil, :name => "Mary"})
      test_patron2.save()
      expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
    end
  end

  describe("#update") do
    it "lets you update a name of patron" do
      patron = Patron.new({:id => nil, :name => "Peter"})
      patron.save()
      patron.update({:name => "Tom"})
      expect(patron.name()).to(eq("Tom"))
    end
  end

  describe("#add_book") do
    it "lets you add a book to a patron" do
      patron = Patron.new({:id => nil, :name => "John"})
      patron.save()
      book1 = Book.new({:id => nil, :name => "Harry Potter", :author => "K.J.Rowling"})
      book1.save()
      book2 = Book.new({:id => nil, :name => "Game of Thrones", :author => "Martin"})
      book2.save()
      patron.add_book({:book_ids =>[book1.id(), book2.id()]})
      expect(patron.books()).to(eq([book1, book2]))
    end
  end

  describe("#books") do
    it "returns all books for a patron" do
      patron = Patron.new({:id => nil, :name => "John"})
      patron.save()
      book1 = Book.new({:id => nil, :name => "Harry Potter", :author => "K.J.Rowling"})
      book1.save()
      book2 = Book.new({:id => nil, :name => "Game of Thrones", :author => "Martin"})
      book2.save()
      patron.add_book({:book_ids =>[book1.id(), book2.id()]})
      expect(patron.books()).to(eq([book1, book2]))
    end
  end

  describe("#delete") do
    it "lets you you delete a patron from the database" do
      patron = Patron.new({:id => nil, :name => "Tom"})
      patron.save()
      patron2 = Patron.new({:id => nil, :name => "Bob"})
      patron2.save()
      patron.delete()
      expect(Patron.all()).to(eq([patron2]))
    end
  end
end
