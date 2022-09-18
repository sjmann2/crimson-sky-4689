require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end

  describe 'instance methods' do
    describe 'popular_ingredients' do
      it 'returns the 3 most used ingredients for a chef' do
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

        expect(chef.popular_ingredients[0].name).to eq("Cheese")
        expect(chef.popular_ingredients[1].name).to eq("Pasta shells")
        expect(chef.popular_ingredients[2].name).to eq("Marinara")

      end
    end
  end
end