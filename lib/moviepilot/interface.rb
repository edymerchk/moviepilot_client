module Moviepilot
  class Interface

    TAGS = %w(superheroes horror young-adult tv)

    def initialize
      @printer = Printer.new
      @articles = []
    end

    def run
      show_welcome_screen
      show_main_menu
    end

    def show_welcome_screen
      @printer.welcome(' Welcome to MoviePilot Client ')
    end

    def show_main_menu
      @printer.title('Main Menu')
      choose do |menu|
        menu.prompt = 'Please enter a number:'
        menu.choice('Read Articles') { show_tags_menu }
        menu.choice('Search') { show_search_menu }
        menu.choice('Exit') {}
      end
    end

    def show_search_menu
      query = ask('What you looking for?')
      @articles = Gateway.search(query).map { |hash| ArticleBuilder.build_v3(hash) }
      show_article_list
    end

    def show_tags_menu
      @printer.title('Select a tag')
      tag = choose do |menu|
        menu.prompt = 'Please enter a number:'
        TAGS.each { |e| menu.choice(e) }
      end
      @articles = Gateway.trending_articles(tag).map { |hash| ArticleBuilder.build_v4(hash) }
      show_article_list
    end

    def show_article_list
      if @articles.size > 0
        @valid_ids = nil
        @printer.articles(@articles)
        pick_article_from_list
      else
        @printer.alert 'No Articles Found :('
        show_main_menu
      end
    end

    def pick_article_from_list
      id_str = ask 'Please enter the ID of one Article'
      id = id_str.to_i
      if valid_ids.include?(id)
        type = @articles.find { |article| article.id == id }.type
        show_article(type, id)
      else
        @printer.alert 'Invalid Article ID, try again...'
        pick_article_from_list
      end
    end

    def valid_ids
      @valid_ids ||= @articles.map { |article| article.id }
    end

    def show_article(type, article_id)
      article = Gateway.get_article(type, article_id)
      @printer.article(article)
      show_main_menu
    end
  end
end
