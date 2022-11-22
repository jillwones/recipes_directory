require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository.rb'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

repo = RecipeRepository.new 

repo.all.each do |recipe|
  puts "#{recipe.name} - Cooking Time (mins): #{recipe.cooking_time} - Rating (out of 5): #{recipe.rating}"
end

recipe = repo.find(1)
puts recipe.name # => outputs 'Burger'
