class Cats < ApplicationRecord
  validates :color, presence: true, inclusion: {in: ["red","orange","green","yellow","blue"]}

  COLORS = ["red","orange","green","yellow","blue"]

  has_many:rentals,
  class_name: "CatRentals",
  primary_key: :id,
  foreign_key: :cat_id,
  dependent: :destroy

end
