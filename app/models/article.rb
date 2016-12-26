class Article < ApplicationRecord
	belongs_to :user
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }
	# Esto setea la cuenta de visitas a 0. Lo hacemos con un before_ ya que no lo seteamos en la bbdd
	before_create :set_visits_count

	private

	def set_visits_count
		self.visits_count = 0
	end
end
