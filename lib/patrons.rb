class Patron
  attr_reader(:id, :name, :history)
  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @history = attributes[:history]
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      id = patron["id"].to_i()
      name = patron["name"]
      history = patron["history"]
      patrons.push(Patron.new({:id => id, :name => name, :history => history}))
    end
    patrons
  end

  define_method(:==) do |another_patron|
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id())).&(self.history().==(another_patron.history()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name, history) VALUES ('#{@name}', '#{@history}') RETURNING id");
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
end
