module Moviepilot
  class Printer

    TRUNCATE_MAX = 40

    def initialize
      @pastel = Pastel.new
    end

    def welcome(text)
      clear
      puts "\n" + @pastel.decorate(text, :white, :on_green, :bold) + "\n\n"
    end

    def title(text)
      puts @pastel.decorate(text, :green, :on_blue) + "\n\n"
    end

    def alert(text)
      puts @pastel.decorate(text, :white, :on_red, :bold) + "\n\n"
    end

    def articles(articles)
      rows = articles.map do |article|
        [article.id, truncate(article.title), truncate(article.author)]
      end
      puts Terminal::Table.new title: 'Articles', headings: %w(ID TITLE AUTHOR), rows: rows
    end

    def article(article)
      title(article['title'])
      puts ReverseMarkdown.convert(article['html_body'])
    end

    private

      def truncate(string)
        string.size <= TRUNCATE_MAX ? string : string[0..TRUNCATE_MAX] + '...'
      end

      def clear
        system('cls') || system('clear') || puts("\e[H\e[2J")
      end
  end
end
