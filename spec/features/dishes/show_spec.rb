# Story 1 of 3
# ```
# As a visitor
# When I visit a dish's show page
# I see the dishs name and description
# And I see a list of ingredients for that dish
# And I see the chef's name.
# ```
require 'rails_helper'

RSpec.describe 'the dish show page' do
  describe 'When I visit a dish show page' do
    it 'I see dish name/description/list of ingredients/chefs name that dish belongs to' do
      chef = Chef.create!(name: 'Chef Boyardee')
      dish_1 = Dish.create!(name: 'Ravioli', description: 'Cheese filled pasta', chef_id: chef.id)
      dish_2 = Dish.create!(name: 'Spaghettios', description: 'Round noodles with sauce', chef_id: chef.id)
      ingredient_1 = Ingredient.create!(name: 'Cheese', calories: 120)
      ingredient_2 = Ingredient.create!(name: 'Pasta', calories: 150)
      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_1.id)
      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_2.id)

      visit dish_path(dish_1)

      expect(page).to have_content(dish_1.name)
      expect(page).to have_content(dish_1.description)
      expect(page).to have_content(ingredient_1.name)
      expect(page).to have_content(ingredient_2.name)
      expect(page).to have_content(chef.name)
      expect(page).to_not have_content(dish_2.name)
    end
  end
end