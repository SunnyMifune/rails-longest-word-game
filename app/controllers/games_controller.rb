require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("a".."z").to_a.sample
    end
  end

  def score
    input = params[:letter]
    array = params[:array_of_letters].split
    contains_all_letters = input.chars.all? {|letter| array.include?(letter)}
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    data = URI.open(url).read
    exist = JSON.parse(data)["found"]

    if !exist
      @message = 'this word doesnt exist'
    elsif !contains_all_letters
      @message = 'you cant write this word with the letters'
    else
      @message = 'you won'
    end

  end
end
