require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe 'instance methods' do
    describe 'total_calories' do
      it 'calculates total calories for the dish' do
        chef = Chef.create!(name: 'Chef Boyardee')
        dish_1 = Dish.create!(name: 'Ravioli', description: 'Cheese filled pasta', chef_id: chef.id)
        dish_2 = Dish.create!(name: 'Spaghettios', description: 'Round noodles with sauce', chef_id: chef.id)
        ingredient_1 = Ingredient.create!(name: 'Cheese', calories: 120)
        ingredient_2 = Ingredient.create!(name: 'Pasta', calories: 150)
        DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_1.id)
        DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_2.id)

        expect(dish_1.total_calories).to eq(270)
        expect(dish_2.total_calories).to eq(0)
      end
    end
  end
end