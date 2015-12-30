module Moviepilot
  class Printer

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

    def table(rows)
      puts Terminal::Table.new title: 'Articles', headings: %w(ID TITLE AUTHOR), rows: rows
    end

    def article(article)
      title(article[:title])
      puts ReverseMarkdown.convert(article[:body])
    end

    def clear
      system("cls") || system("clear") || puts("\e[H\e[2J")
    end
  end
end
