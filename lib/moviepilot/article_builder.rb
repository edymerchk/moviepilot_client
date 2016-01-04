class ArticleBuilder

  def self.build_v3(hash)
    Article.new(
      id: hash.fetch('id'),
      title: hash.fetch('name'),
      author: hash.fetch('additional_data').fetch('author').fetch('name'),
      type: hash.fetch('type')
    )
  end

  def self.build_v4(hash)
    Article.new(
      id: hash.fetch('id'),
      title: hash.fetch('title'),
      author: hash.fetch('author').fetch('name'),
      type: hash.fetch('type')
    )
  end
end
