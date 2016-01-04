class Article

  attr_accessor :id, :title, :author, :type

  def initialize(id: id, title: title, author: author, type: type)
    @id = id
    @title = title
    @author = author
    @type = type
  end

end
