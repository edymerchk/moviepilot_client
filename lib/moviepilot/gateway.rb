module Moviepilot
  class Gateway

    BASE_PATH = 'http://api.moviepilot.com'
    PER_PAGE = 8

    def self.trending_articles(tag)
      uri = uri_for("tags/#{tag}/trending")
      result = get_request(uri, per_page: PER_PAGE)
      result['collection']
    end

    def self.get_article(type, id)
      uri = uri_for("#{type.pluralize}/#{id}")
      get_request(uri)
    end

    def self.search(query)
      uri = uri_for('search', 'v3')
      result = get_request(uri, q: query, per_page: PER_PAGE, without_type: 'user,tag')
      result['search']
    end

    def self.uri_for(endpoint, api_version = 'v4')
      [BASE_PATH, api_version, endpoint].join('/')
    end

    def self.get_request(uri, params = {})
      response = RestClient.get(uri, params: params)
      JSON.parse(response)
    end
  end
end
