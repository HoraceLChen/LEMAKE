# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

RecipeIngredient.destroy_all
UploadedIngredient.destroy_all
Ingredient.destroy_all
Review.destroy_all
Meal.destroy_all
User.destroy_all
Recipe.destroy_all

user1 = User.create(email: "horace@lewagon.co", password: "password")
user2 = User.create(email: "aliia@lewagon.co", password: "password")
user3 = User.create(email: "kai@lewagon.co", password: "password")
user4 = User.create(email: "vincent@lewagon.co", password: "password")
users = [user1, user2, user3, user4]

6.times do
  User.create(email: Faker::Internet.email(domain: "lewagon.co"), password: "password")
end
p 'users made'
chicken = Ingredient.create(
  name: "chicken drumstick"
)
flour = Ingredient.create(
  name: "flour"
)
egg = Ingredient.create(
  name: "egg"
)
Ingredient.create(
  name: "beef steak"
)
30.times do
  Ingredient.create(
    name: Faker::Food.ingredient
  )
end
p 'ingredients made'

recipe1 = Recipe.create(
  title: "Vincent's Fried Chicken",
  image: "https://www.coles.com.au/content/dam/coles/inspire-create/july22-images/Jul22-The-new-fried-chicken-976x549.jpg",
  content: "Southern beer battered chicken wings",
  cuisine: "American",
  time: 2,
  people: 3
)
RecipeIngredient.create(
  serving: 6,
  ingredient: chicken,
  recipe: recipe1
)
RecipeIngredient.create(
  serving: 2,
  ingredient: flour,
  recipe: recipe1
)
RecipeIngredient.create(
  serving: 3,
  ingredient: egg,
  recipe: recipe1
)
# recipe2 = Recipe.create(
#   title: "Vincent's Fried Chicken",
#   image: "https://www.coles.com.au/content/dam/coles/inspire-create/july22-images/Jul22-The-new-fried-chicken-976x549.jpg",
#   content: "Southern beer battered chicken wings",
#   cuisine: "American",
#   time: 2,
#   people: 3
# )
# RecipeIngredient.create(
#   serving: rand(1..5),
#   ingredient_id: Ingredient.all.sample.id,
#   recipe_id: recipe2.id
# )

30.times do
  recipe = Recipe.create(
    title: Faker::Food.dish,
    image: "http://source.unsplash.com/featured/?#{Faker::Food.ethnic_category}&#{rand(1000)}",
    content: Faker::Food.description,
    cuisine: Faker::Food.ethnic_category,
    time: rand(1..5),
    people: rand(1..10)
  )
  RecipeIngredient.create(
    serving: rand(1..5),
    ingredient_id: Ingredient.all.sample.id,
    recipe_id: recipe.id
  )
end

p 'recipes made'
20.times do
  meal = Meal.create(
    user_id: User.all.sample.id,
    recipe_id: Recipe.all.sample.id,
    cuisine_preference: Faker::Food.ethnic_category,
    img: "http://source.unsplash.com/featured/?#{Faker::Food.ethnic_category}&#{rand(1000)}",
    time_preference: rand(1..3),
    people_preference: rand(1..5)
  )
  UploadedIngredient.create(
    meal_id: meal.id,
    ingredient_id: Ingredient.all.sample.id
  )
end
p 'meals created'

Review.create(
  content: "No sugar",
  meal_id: Meal.all.sample.id
)

Review.create(
  content: "Change thyme for basil",
  meal_id: Meal.all.sample.id
)

Review.create(
  content: "I like this one!",
  meal_id: Meal.all.sample.id
)
p 'reviews created'
