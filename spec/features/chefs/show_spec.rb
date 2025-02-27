require 'rails_helper'

RSpec.describe 'the chef show page' do
  describe 'When I visit a chefs show page' do
    it 'I see chef name and a link to view a list of all ingredients this chef uses in their dishes' do
      chef = Chef.create!(name: 'Chef Boyardee')
      dish_1 = Dish.create!(name: 'Ravioli', description: 'Cheese filled pasta', chef_id: chef.id)
      dish_2 = Dish.create!(name: 'Spaghettios', description: 'Round noodles with sauce', chef_id: chef.id)
      cheese = Ingredient.create!(name: 'Cheese', calories: 120)
      pasta = Ingredient.create!(name: 'Pasta shells', calories: 150)
      noodles = Ingredient.create!(name: 'Pasta noodles', calories: 150)
      meatballs = Ingredient.create!(name: 'meatballs', calories: 200)
      marinara = Ingredient.create!(name: 'marinara', calories: 200)

      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: cheese.id)
      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: marinara.id)

      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: noodles.id)
      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: meatballs.id)
      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: marinara.id)

      visit chef_path(chef)

      expect(page).to have_content(chef.name)
      expect(page).to have_link('All ingredients')
    end

    it 'The link redirects to a chef ingredient index page and I see names of all ingredients this chef uses' do
      chef = Chef.create!(name: 'Chef Boyardee')
      dish_1 = Dish.create!(name: 'Ravioli', description: 'Cheese filled pasta', chef_id: chef.id)
      dish_2 = Dish.create!(name: 'Spaghettios', description: 'Round noodles with sauce', chef_id: chef.id)
      cheese = Ingredient.create!(name: 'Cheese', calories: 120)
      pasta = Ingredient.create!(name: 'Pasta shells', calories: 150)
      noodles = Ingredient.create!(name: 'Pasta noodles', calories: 150)
      meatballs = Ingredient.create!(name: 'Meatballs', calories: 200)
      marinara = Ingredient.create!(name: 'Marinara', calories: 200)

      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: cheese.id)
      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: marinara.id)

      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: noodles.id)
      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: meatballs.id)
      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: marinara.id)

      visit chef_path(chef)

      click_link "All ingredients"

      expect(current_path).to eq(chef_ingredients_path(chef))

      expect(page).to have_content(cheese.name)
      expect(page).to have_content(pasta.name)
      expect(page).to have_content(noodles.name)
      expect(page).to have_content(meatballs.name)
      expect(page).to have_content(marinara.name)
    end

    it "the three most popular ingredients the chef uses are listed" do
      chef = Chef.create!(name: 'Chef Boyardee')
      dish_1 = Dish.create!(name: 'Ravioli', description: 'Cheese filled pasta', chef_id: chef.id)
      dish_2 = Dish.create!(name: 'Spaghettios', description: 'Round noodles with sauce', chef_id: chef.id)
      cheese = Ingredient.create!(name: 'Cheese', calories: 120)
      pasta = Ingredient.create!(name: 'Pasta shells', calories: 150)
      meatballs = Ingredient.create!(name: 'Meatballs', calories: 200)
      marinara = Ingredient.create!(name: 'Marinara', calories: 200)

      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: cheese.id)
      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: dish_1.id, ingredient_id: marinara.id)

      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: meatballs.id)
      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: marinara.id)
      DishIngredient.create!(dish_id: dish_2.id, ingredient_id: cheese.id)

      visit chef_path(chef)
      
      expect(page).to have_content("Three most popular ingredients for #{chef.name}")
      expect(page).to have_content("Cheese")
      expect(page).to have_content("Pasta shells")
      expect(page).to have_content("Marinara")
      expect(page).to_not have_content("Meatballs")
    end
  end
end
