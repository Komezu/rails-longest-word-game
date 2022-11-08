require 'open-uri'

# Controller for the game
class GamesController < ApplicationController
  before_action :set_score

  def reset
    session[:score] = nil
    redirect_to new_path
  end

  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << alphabet.sample }
  end

  def score
    @grid = params[:letters].chars
    @word = params[:word].strip.upcase

    word_data = parse_word(@word)

    if !grid_valid?(@grid, @word)
      @fail = 'grid_fail'
    elsif !word_data['found']
      @fail = 'english_fail'
    else
      @score = update_score(word_data)
    end
  end

  private

  def set_score
    if session[:score].nil?
      @score = 0
      session[:score] = 0
    else
      @score = session[:score]
    end
  end

  def parse_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(URI.parse(url).open.read)
  end

  def grid_valid?(grid, word)
    word = word.chars
    word.all? { |char| word.count(char) <= grid.count(char) }
  end

  def update_score(word_data)
    session[:score] += word_data['length']
    session[:score]
  end
end
