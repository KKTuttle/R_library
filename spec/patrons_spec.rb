require('spec_helper')

describe(Patron) do
  describe(".all") do
    it "will be empty at the beginning" do
      expect(Patron.all()).to(eq([]))
    end
  end
  describe("#==") do
    it "is the same patron if they have the same info" do
      test_patron = Patron.new({:id => nil, :name => "Bob", :history => "[]"})
      test_patron2 = Patron.new({:id => nil, :name => "Bob", :history => "[]"})
      expect(test_patron).to(eq(test_patron2))
    end
  end

  describe("#save") do
    it "saves a patron to the array of patrons" do
      test_patron = Patron.new({:id => nil, :name => "Bob", :history => "[]"})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe(".find") do
    it "returns a patron by id number" do
      test_patron = Patron.new({:id => nil, :name => "Bob", :history => "[]"})
      test_patron.save()
      test_patron2 = Patron.new({:id => nil, :name => "Mary", :history => "[]"})
      test_patron2.save()
      expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
    end

  end
end
