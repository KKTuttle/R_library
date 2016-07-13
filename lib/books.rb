class Book
  attr_reader(:id, :name, :author)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @author = attributes[:author]

  end
  define_singleton_method(:all) do
    @books = []
    
  end

end
