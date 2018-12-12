KEY = Rails.application.secrets.movie_db

#Movies
response = HTTParty.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{KEY}")
response['results'].each { |movie| Movie.create!(title: movie['title'], plot: movie['overview']) }

#Seasons and its episodes
response = HTTParty.get("https://api.themoviedb.org/3/tv/popular?api_key=#{KEY}")
tv_shows = response['results'].pluck('id', 'name', 'overview')
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
