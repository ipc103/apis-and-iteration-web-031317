require 'rest-client'
require 'json'
require 'pry'

def fetch_characters
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  characters_hash = JSON.parse(all_characters)
end

def get_character_movies_from_api(character_name)
  characters_hash = fetch_characters

  character_data = characters_hash["results"].find do |character_hash|
    character_hash["name"].downcase == character_name
  end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  #=> [{title: 'The Force Awakens'}, {title: 'Return of the Jedi'}, {title: 'Rogue One'}]
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  film_urls = character_data["films"]
  films = film_urls.collect do |film_url|
    film_response = RestClient.get(film_url)
    JSON.parse(film_response)
  end
end

def parse_character_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each.with_index(1) do |film, i|
    puts "#{i}. #{film["title"]}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  parse_character_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
