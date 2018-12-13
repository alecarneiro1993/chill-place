class Api::FetchController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    render json: {
      movies: Movie.all.order(id: :asc, created_at: :desc),
      seasons: format_seasons_json
    }
  end

  def movies
    render json: {
      movies: Movie.all.order(id: :asc, created_at: :desc)
    }
  end

  def seasons
    render json: {
      seasons: format_seasons_json
    }
  end


  private
  def format_seasons_json
    Season.all.order(id: :asc, created_at: :desc).map { |season|
     s = season.attributes
     s[:episodes] = season.episodes.order(id: :asc)
     s
    }
  end
end
