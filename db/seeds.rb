# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
chef = Chef.create!(name: 'Chef Boyardee')
dish_1 = Dish.create!(name: 'Ravioli', description: 'Cheese filled pasta', chef_id: chef.id)
dish_2 = Dish.create!(name: 'Spaghettios', description: 'Round noodles with sauce', chef_id: chef.id)
ingredient_1 = Ingredient.create!(name: 'Cheese', calories: 120)
ingredient_2 = Ingredient.create!(name: 'Pasta', calories: 150)
DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_1.id)
DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_2.id)