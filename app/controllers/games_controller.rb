require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    guess = params[:guess].upcase
    letters = params[:letters]

    @result =
      if guess_included?(guess, letters)
        english_word?(guess) ? "Congratulations! #{guess} is a valid English word! Your score: #{guess.size * 17} points!" : "Sorry but #{guess} is not valid."
      else
        "Sorry but #{guess} can't be built out of #{letters}."
      end
  end

  private

  def guess_included?(guess, letters)
    guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
