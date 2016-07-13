require('spec_helper')

describe(Checkout) do
  describe(".all") do
    it "will be empty at the beginning" do
      expect(Checkout.all()).to(eq([]))
    end
  end

  describe("#==") do
    it "is the same checkout if they have the same info" do
      test_checkout = Checkout.new({:id => nil, :due => "2016-07-13", :book_id => 1, :patron_id => 1})
      test_checkout2 = Checkout.new({:id => nil, :due => "2016-07-13", :book_id => 1, :patron_id => 1})
      expect(test_checkout).to(eq(test_checkout2))
    end
  end

  describe("#save") do
    it "saves a checkout to the array of patrons" do
      test_checkout = Checkout.new({:id => nil, :due => "2016-07-13", :book_id => 1, :patron_id => 1})
      test_checkout.save()
      expect(Checkout.all()).to(eq([test_checkout]))
    end
  end

  describe(".find") do
    it "returns a checkout by id number" do
      test_checkout = Checkout.new({:id => nil, :due => "2016-07-13", :book_id => 1, :patron_id => 1})
      test_checkout.save()
      expect(Checkout.find(test_checkout.id())).to(eq(test_checkout))
    end
  end
end
