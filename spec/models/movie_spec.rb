require 'rails_helper'

KEY = Rails.application.secrets.movie_db

RSpec.describe Movie, type: :model do
  it '#create' do
    response = HTTParty.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{KEY}")
    response['results'].each { |movie| Movie.create!(title: movie['title'], plot: movie['overview']) }
    expect(Movie.any?).to be_truthy
  end
end
