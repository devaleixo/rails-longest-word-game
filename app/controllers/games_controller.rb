require 'open-uri'
require 'json'
require 'nokogiri'
class GamesController < ApplicationController
  def new
    @array_words = ('a'..'z').to_a + ('a'..'z').to_a
    @game_words = @array_words.sample(10)
  end

  def score
    @game_words = params[:game_words]
    @prahse = ''
    check_word = "https://wagon-dictionary.herokuapp.com/#{params[:attempt]}"
    read_link = URI.open(check_word).read
    json_hash = JSON.parse(read_link)
    if (params[:attempt].chars - params[:game_words].split(" ")).empty?
      @prahse = "Congratulations <strong>#{params[:attempt]}</strong> is a valid English word!"
    elsif json_hash['found'] == false
      @prahse = "Sorry but <strong>#{params[:attempt]}</strong> does not seem to be a valid English word..."
    else
      @prahse = "Sorry but <strong>#{params[:attempt]}</strong> can't be built out of #{@game_words}"
    end
  end
end
