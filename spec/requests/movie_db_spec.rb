require 'rails_helper'

KEY = Rails.application.secrets.movie_db

RSpec.describe 'MovieDB' do
  it '#GET current 20 top rated movies' do
    response = HTTParty.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{KEY}")
    expect(response['results'].size).to eq(20)
  end

  it '#GET ids from 20 popular TV Shows and fetch their first season' do
    response = HTTParty.get("https://api.themoviedb.org/3/tv/popular?api_key=#{KEY}")
    tv_shows = response['results'].pluck('id', 'name', 'overview')
    expect(tv_shows.size).to eq(20)
    tv_shows.each { |tv_show|
      response = HTTParty.get("https://api.themoviedb.org/3/tv/#{tv_show[0]}/season/1?api_key=#{KEY}")
      expect(response).not_to be_nil
    }
  end
end
