require 'rest-client'

class Gateway
  def self.trending_articles(tag)
    uri = "http://api.moviepilot.com/v4/tags/#{tag}/trending?per_page=4"
    response = RestClient.get(uri)
    JSON.parse(response)['collection']
  end

  def self.get_article(type, id)
    uri = "http://api.moviepilot.com/v4/#{type}s/#{id}"
    response = RestClient.get(uri)
    article = JSON.parse(response)
    { body: article['html_body'], title: article['title'] }
  end
end
