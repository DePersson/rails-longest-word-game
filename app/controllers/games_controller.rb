require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    array = ('A'..'Z').to_a
    @letters = array.shuffle[1, 10]
  end

  def score
    if !check_attempt_letters?(params[:word], params[:letters])
      @result = "Sorry but #{params[:word]} can't be built with the #{params[:letters]}"
    elsif !check_attempt_word_ok?(params[:word])
      @result = "Sorry but #{params[:word]} doesn't seem to be a valid English word"
    else
      @result = "Congratulations! #{params[:word]} is a valid English word"
    end
  end

  def check_attempt_letters?(attempt, grid)
    attempt.upcase.split('').each do |letter|
      return false if attempt.upcase.count(letter) > grid.count(letter)
    end
    true
  end

  def check_attempt_word_ok?(attempt)
    url = 'https://wagon-dictionary.herokuapp.com/'
    word_api = JSON.parse(open("#{url}#{attempt}").read)
    if word_api['found'] == true
      return true
    else
      return false
    end
  end
end
