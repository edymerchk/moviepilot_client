module Moviepilot
  class Interface

    TAGS = %w(superheroes horror young-adult tv)

    def initialize
      @pastel_print = PastelPrint.new
      @articles = []
    end

    def run
      show_welcome_screen
      show_main_menu
    end

    def show_welcome_screen
      @pastel_print.welcome(' Welcome to MoviePilot Client ')
    end

    def show_main_menu
      @pastel_print.title('Main Menu')
      choose do |menu|
        menu.prompt = "Please enter a number:"
        menu.choice("Read Articles") { show_tags_menu }
        menu.choice("Search") { puts "search menu"}
        menu.choice("Exit") {}
      end
    end

    def show_tags_menu
      @pastel_print.title('Select a tag')
      tag = choose do |menu|
        menu.prompt = "Please enter a number:"
        TAGS.each{ |e| menu.choice(e) }
      end
      @articles = Gateway.trending_articles(tag)
      show_article_list
    end

    def show_article_list
      rows = []
      @articles.each_with_index do |article|
        id     = article['id']
        title  = article['title']
        author = article['author']['name']
        rows << [id, title, author]
      end
      table = Terminal::Table.new title: 'Articles', headings: %w(ID TITLE AUTHOR), rows: rows
      puts table
      pick_article_from_list
    end

    def pick_article_from_list
      valid_ids = @articles.map{|article| article['id']}
      id_str = ask "Please enter the ID of one Article"
      id = id_str.to_i
      if valid_ids.include?(id)
        show_article("post", id)
      else
        @pastel_print.alert "Invalid Article ID, try again..."
        pick_article_from_list
      end
    end

    def show_article(type, article_id)
      article = Gateway.get_article("post", article_id)
      @pastel_print.title(article[:title])
      puts ReverseMarkdown.convert(article[:body])
      show_main_menu
    end

  end
end
