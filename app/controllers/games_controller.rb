class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end
  def score
    @guess = params[:guess]
    @letters = params[:letters]

    if included?(@guess, @letters)
      # The word can`t be built out of the original grid
      # The word is valid according to the grid, but is not a valid English word
      # The word is valid according to the grid and is an English word
      if english_word?(@guess)
        @output = "Sorry but #{@guess.upcase} does not seem to be a valid English word…"
        @output
      else
        @output = "Sorry but #{@guess.upcase} can't be build of #{@letters}"
        @output
      end
    else
      @output = "Congratulations! #{@guess.upcase} is a valid English word!"
      @output
    end
  end

  def included?(guess, letters)
    guess.chars.all? { |char| guess.count(char) <= letters.count(char) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']

    # url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # content = RestClient.get(url)
    # flats = JSON.parse(content, symbolize_names: true)
  end
end

