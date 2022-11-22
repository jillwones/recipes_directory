# Recipe Model and Repository Classes Design Recipe

## 1. Design and create the Table

```sql
CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  name text,
  cooking_time int,
  rating int
);
```

## 2. Create Test SQL seeds

```sql
TRUNCATE TABLE recipes RESTART IDENTITY;

INSERT INTO recipes
(name, cooking_time, rating)
VALUES('Spag Bol', 15, 4);

INSERT INTO recipes
(name, cooking_time, rating)
VALUES('Pizza', 30, 5);
```

## 3. Define the class names

```ruby
class Recipe

end 

class RecipeRepository

end
```

## 4. Implement the Model class

```ruby
class Recipe
  attr_accessor :id, :name, :cooking_time, :rating
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

```ruby
class RecipeRepository

  def all 
    # Executes the SQL query:
    # SELECT id, name, cooking_time, rating FROM recipes;
    # returns an array of recipe objects
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;
    # returns a single recipe object
  end
  
end
```

## 6. Write Test Examples

```ruby
# 1
# Get all recipes

repo = RecipeRepository.new 
recipes = repo.all

recipes.length # => 2
recipes.first.name # => 'Spag Bol'
recipes.first.cooking_time # => 15
recipes.first.rating # => 4

# 2
# Get a single recipe

repo = RecipeRepository.new
recipe = repo.find(1)
recipe.name # => 'Spag Bol'
recipe.cooking_time # => 15
recipe.rating # => 4

# 3
# Get another single recipe

repo = RecipeRepository.new
recipe = repo.find(2)
recipe.name # => 'Pizza'
recipe.cooking_time # => 30
recipe.rating # => 5
```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/recipe_test_seed.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end
  
describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._