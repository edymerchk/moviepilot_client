module Moviepilot
  class Gateway

    BASE_PATH = "http://api.moviepilot.com/v4"

    def self.trending_articles(tag)
      uri = "#{BASE_PATH}/tags/#{tag}/trending?per_page=4"
      result = get_request(uri)
      result['collection']
    end

    def self.get_article(type, id)
      uri = "#{BASE_PATH}/#{type}s/#{id}"
      article = get_request(uri)
      { body: article['html_body'], title: article['title'] }
    end

     def self.get_request(uri)
      response = RestClient.get(uri)
      JSON.parse(response)
    end
  end
end
