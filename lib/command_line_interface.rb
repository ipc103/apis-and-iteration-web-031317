def welcome
  puts '*' * 30
  puts 'Welcome to the greatest star wars app in the history of the world...'
  puts '*' * 30
end

def get_character_from_user
  puts "please enter a character"
  gets.strip.downcase
end
