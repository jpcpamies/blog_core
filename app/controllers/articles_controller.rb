class ArticlesController < ApplicationController
	# Esto funciona con el método privado before_action (ahora comentado)
	# before_action :validate_user, except: [:show, :index]
	# Utilizando el método helper de Devise para hacer lo mismo que la línea de código anterir. Sólo que con esta no hace falta el método privado del final de la página
	before_action :authenticate_user!

	#GET /articles
	def index
		# Obtienen todos los registros
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		# Encuentra el registro por su id
		@article = Article.find(params[:id])
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	#GET /articles/new
	def edit
		# Encuentra el registro por su id
		@article = Article.find(params[:id])
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
		@article = Article.find(params[:id])
		# Segundo eliminar el objeto de la base de datos
		@article.destroy
		# Redirigir a la lista de artículos
		redirect_to articles_path
	end

	#PUT /articles/:id
	def update
		# Encuentra el registro por su id
		@article = Article.find(params[:id])
		# Si el artcículo se guarda redirige al artículo,
		if @article.update(article_params)
			redirect_to @article
		else
			# si no redirige a la acción edit
			render :edit
		end
	end

	private

	# Esto funciona junto al before_action del principio para requerir acciones antes o después de ciertas acciones
	# def validate_user
	# 	redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	# end

	def article_params
		# Aquí estoy diciendo donde no hay problema que el usuario mande datos para estos campos 
		params.require(:article).permit(:title,:body)
	end




end