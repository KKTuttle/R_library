require('spec_helper')

describe(Book) do
  describe('.all') do
    it "will be first at the beginning" do
      expect(Book.all()).to(eq([]))
    end
  end
end
