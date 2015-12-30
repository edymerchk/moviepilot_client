require 'pastel'

class PastelPrint

  def initialize
    @pastel = Pastel.new
  end

  def title(text)
    puts @pastel.decorate(text, :green, :on_blue, :bold)
  end

  def alert(text)
    puts @pastel.decorate(text, :white, :on_red, :bold)
  end

end
