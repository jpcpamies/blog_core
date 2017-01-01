class Article < ApplicationRecord
	belongs_to :user
	has_many :has_categories
	has_many :categories, through: :has_categories

	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }
	# Esto setea la cuenta de visitas a 0. Lo hacemos con un before_ ya que no lo seteamos en la bbdd
	before_create :set_visits_count
	# call back del modelo que manda llamar :save_catagories cuando el artículo se crea. Es ahí donde tenemos que crear los registros HasCategories.
	after_create :save_categories

	# Paperclip
	has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
	
	# Agragando el elemento categories dentro del objeto article
	# Custom setter, permite asignar valor al atributo de un objeto
	def categories=(valeu)
		@categories = valeu
	end

	# Hace que aumente el número de visitas en uno cada vez que se carga el artículo
	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end


	private

	# Aquí es donde mandamos crear los registros HasCategories que nos permiten crear la relación muchos a muchos.
	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id,article_id: self.id)
		end
	end

	def set_visits_count
		self.visits_count = 0
	end
end
