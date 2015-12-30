module Moviepilot
  class Gateway

    BASE_PATH = "http://api.moviepilot.com"

    def self.trending_articles(tag)
      uri = uri_for("tags/#{tag}/trending")
      result = get_request(uri, { per_page: 4 })
      result['collection']
    end

    def self.get_article(type, id)
      uri = uri_for("#{type.pluralize}/#{id}")
      article = get_request(uri)
      { body: article['html_body'], title: article['title'] }
    end

    def self.search(query)
      uri = uri_for("search", "v3" )
      result = get_request(uri, { q: query, per_page: 18, without_type: "user,tag" })
      result['search']
    end

    def self.uri_for(endpoint, api_version = 'v4')
      [BASE_PATH, api_version, endpoint].join('/')
    end

    def self.get_request(uri, params = { })
      response = RestClient.get(uri, params: params )
      JSON.parse(response)
    end
  end
end
