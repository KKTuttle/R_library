class Checkout
  attr_reader(:id, :due, :book_id, :patron_id)
  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @due = attributes[:due]
    @book_id = attributes[:book_id]
    @patron_id = attributes[:patron_id]
  end

  define_singleton_method(:all) do
    returned_checkouts = DB.exec("SELECT * FROM checkouts;")
    checkouts = []
    returned_checkouts.each() do |checkout|
      id = checkout["id"].to_i()
      due = checkout["due"]
      book_id = checkout["book_id"].to_i()
      patron_id = checkout["patron_id"].to_i()
      checkouts.push(Checkout.new({:id => id, :due => due, :book_id => book_id, :patron_id => patron_id}))
    end
    checkouts
  end

  define_method(:==) do |another_checkout|
    self.id().==(another_checkout.id()).&(self.due().==(another_checkout.due())).&(self.book_id().==(another_checkout.book_id())).&(self.patron_id().==(another_checkout.patron_id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO checkouts (due, book_id, patron_id) VALUES ('#{@due}', #{@book_id}, #{@patron_id}) RETURNING id");
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_checkout = nil
    Checkout.all().each() do |checkout|
      if checkout.id().==(id)
        found_checkout = checkout
      end
    end
    found_checkout
  end
end
