require 'open-uri'

# Controller for the game
class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << alphabet.sample }
  end

  def score
    @grid = params[:letters].chars
    @word = params[:word].upcase

    @message = if !grid_valid?(@grid, @word)
                 'grid_fail'
               elsif !english_valid?(@word)
                 'english_fail'
               else
                 'success'
               end
  end

  private

  def grid_valid?(grid, word)
    word = word.chars
    word.all? { |char| word.count(char) <= grid.count(char) }
  end

  def english_valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_data = JSON.parse(URI.parse(url).open.read)
    word_data['found'] == true
  end
end
