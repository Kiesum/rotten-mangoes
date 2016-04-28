require 'omdbapi'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Movie.new(title: 'Sample', director: "Ridley Scott", runtime_in_minutes: 130, description: "movie bout a gladiator", image: "gladiator.jpg")

 @movies = Imdb::Top250.new
 @movies = @movies.movies

 # runtime = @result.runtime.split(' ')[0].to_i
@movies.each do |m| 
   Movie.create(
    title: m.title,
    director: m.director[0],
    runtime_in_minutes: m.length, 
    description: m.plot,
    poster_image_url: m.poster,
    release_date: DateTime.parse(m.release_date)
    )
   puts m.title
end

