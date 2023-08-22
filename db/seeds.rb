# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Ingredient.destroy_all
Review.destroy_all
RecipeIngredient.destroy_all
UploadedIngredient.destroy_all
Meal.destroy_all
User.destroy_all
Recipe.destroy_all

user1 = User.create(email: "horace@lewagon.co", password: "password")
user2 = User.create(email: "aliia@lewagon.co", password: "password")
user3 = User.create(email: "kai@lewagon.co", password: "password")
user4 = User.create(email: "vincent@lewagon.co", password: "password")
users = [user1, user2, user3, user4]

Ingredient.create(name: "apple")

recipe = Recipe.create(
    title: "Apple meal",
    image: "http://source.unsplash.com/featured/",
    content: "Apple is good",
    cuisine: "fruits",
    time: rand(1..5),
    people: rand(1..10)
  )

  RecipeIngredient.create(
    serving: rand(1..5),
    ingredient_id: Ingredient.all.sample.id,
    recipe_id: recipe.id
  )

  meal = Meal.create(
    user_id: User.all.sample.id,
    recipe_id: Recipe.all.sample.id,
    cuisine_preference: "Faker::Food.ethnic_category",
    img: "http://source.unsplash.com/featured/",
    time_preference: rand(1..3),
    people_preference: rand(1..5)
  )
  UploadedIngredient.create(
    meal_id: meal.id,
    ingredient_id: Ingredient.all.sample.id
  )

  Review.create(
    rating: rand(1..5),
    content: "This was amazing",
    meal_id: Meal.all.sample.id
  )
