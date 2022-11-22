require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('spec/recipe_test_seed.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end
  
describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  it 'gets all recipes in the repo' do 
    repo = RecipeRepository.new 
    recipes = repo.all

    expect(recipes.length).to eq(2)
    expect(recipes.first.name).to eq('Spag Bol')
    expect(recipes.first.cooking_time).to eq('15')
    expect(recipes.first.rating).to eq('4')
  end

  it 'gets a single recipe' do
    repo = RecipeRepository.new
    recipe = repo.find(1)

    expect(recipe.name).to eq('Spag Bol') 
    expect(recipe.cooking_time).to eq('15') 
    expect(recipe.rating).to eq('4')
  end

  it 'gets another recipe' do
    repo = RecipeRepository.new
    recipe = repo.find(2)

    expect(recipe.name).to eq('Pizza') 
    expect(recipe.cooking_time).to eq('30') 
    expect(recipe.rating).to eq('5')
  end
end