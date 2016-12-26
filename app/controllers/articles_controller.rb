class ArticlesController < ApplicationController
	# Esto funciona con el método privado before_action (ahora comentado)
	# before_action :validate_user, except: [:show, :index]
	# Utilizando el método helper de Devise para hacer lo mismo que la línea de código anterir. Sólo que con esta no hace falta el método privado del final de la página
	# Se le puede añadir un hash de opciones para que solo valide en las acciones que quieras. 
	# Si añado el except: lo va a validar siempre con la excepción de lo de dentro de los []
	before_action :authenticate_user!, except: [:show, :index]
	# Todas las acciones donde había un params id lo vamos a mover a un before action. Y le dacimos excepto las acciones donde no usamos lo de paramas id
	before_action :set_article, except: [:index, :new, :create]

	#GET /articles
	def index
		# Obtienen todos los registros
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		# Encuentra el registro por su id
		# Ahora el find paramas id que se repetía en esta acción y otras se ha pasado a un before_action
		# @article = Article.find(params[:id])

		@article.update_visits_count
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	#GET /articles/new
	def edit
		# Encuentra el registro por su id
		# Ahora el find paramas id que se repetía en esta acción y otras se ha pasado a un before_action
		# @article = Article.find(params[:id])
	end

	#POST /articles
	def create
		@article = current_user.articles.new(article_params)
		if @article.save 
			redirect_to @article
		else
		 	render :new
		end
	end

	#DELETE /articles/:id
	def destroy
		# Primero buscar el artículo que el usuario quiere eliminar
		# Ahora el find paramas id que se repetía en esta acción y otras se ha pasado a un before_action
		# @article = Article.find(params[:id])

		# Segundo eliminar el objeto de la base de datos
		@article.destroy
		# Redirigir a la lista de artículos
		redirect_to articles_path
	end

	#PUT /articles/:id
	def update
		# Encuentra el registro por su id
		# Ahora el find paramas id que se repetía en esta acción y otras se ha pasado a un before_action
		# @article = Article.find(params[:id])


		# Si el artcículo se guarda redirige al artículo,
		if @article.update(article_params)
			redirect_to @article
		else
			# si no redirige a la acción edit
			render :edit
		end
	end

	private

	# Esto permite borrar todas las veces que se repetía la misma línea de código
	def set_article
		@article = Article.find(params[:id])
	end

	# Esto funciona junto al before_action del principio para requerir acciones antes o después de ciertas acciones
	# def validate_user
	# 	redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	# end

	def article_params
		# Aquí estoy diciendo donde no hay problema que el usuario mande datos para estos campos 
		params.require(:article).permit(:title,:body)
	end




end