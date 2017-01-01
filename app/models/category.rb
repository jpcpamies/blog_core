class Category < ApplicationRecord
	validates :name, presence: true
	has_many :has_categories
	has_many :articles, through: :has_categories
end

# La table del medio es la que nos permite realcionar Category con Article y decir que category tiene muchos artículos y que un artículo pertenece a muchos categories
# Category - HasCategory - Article