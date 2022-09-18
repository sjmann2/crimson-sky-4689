class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def popular_ingredients
    dishes.joins(:ingredients).group('ingredients.id').select('ingredients.*, count(ingredients.id) as count').order(count: :desc).limit(3)
  end
end