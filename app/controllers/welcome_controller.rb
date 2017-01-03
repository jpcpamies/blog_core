class WelcomeController < ApplicationController
	# Esto dice que solo el admin puede acceder al dashboard
	before_action :authenticate_admin!, only: [:dashboard]
  def index
  end

  def dashboard
  	@articles = Article.all
  end
end
