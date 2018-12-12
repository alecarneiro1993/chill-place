require 'rails_helper'

KEY = Rails.application.secrets.movie_db

RSpec.describe 'Season and Episodes', type: :model do
  it '#create season along with its episodes' do
    response = HTTParty.get("https://api.themoviedb.org/3/tv/popular?api_key=#{KEY}")
    tv_shows = response['results'].pluck('id', 'name', 'overview')
    expect(tv_shows.size).to eq(20)
    tv_shows.each { |tv_show|
      response = HTTParty.get("https://api.themoviedb.org/3/tv/#{tv_show[0]}/season/1?api_key=#{KEY}")
      season = Season.create(title: tv_show[1], plot: tv_show[2])
      response['episodes'].each { |episode|
        season.episodes.create(
          title: episode['name'],
          plot: episode['overview'],
          episode_number: episode['episode_number']
        )
      }
    }
    expect(Season.all.size).to be > 5
    expect(Episode.all.size).to be > 5
  end
end
