class Article < ApplicationRecord
	include AASM
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
	
	# Definiendo scopes para definir diferentes grupos de la tabla.
	scope :publicados, ->{ where(state: "published") } 
	scope :ultimos, ->{ order("created_at DESC") }

	# Pertenece a friendly_id
	extend FriendlyId
	friendly_id :title, use: :slugged

	# Agragando el elemento categories dentro del objeto article.
	# Custom setter, permite asignar valor al atributo de un objeto.
	def categories=(valeu)
		@categories = valeu
	end

	# Hace que aumente el número de visitas en uno cada vez que se carga el artículo
	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	aasm column: "state" do
		# Aquí defino los estados en los que puede estar un article.
		state :in_draft, initial: true
		state :published

		# Aquí defino las transiciones posibles para pasar de un estado a otro.
		event :publish do
			# transitions from: :in_draft, to: :published
			transitions from: [:in_draft], to: [:published]
		end 

		event :unpublish do
			# transitions from: :published, to: :in_draft
			transitions from: [:published], to: [:in_draft]
		end 

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
