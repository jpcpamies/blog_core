class ArticlesController < ApplicationController

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
		@article = Article.new(article_params)
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

	def article_params
		# Aquí estoy diciendo donde no hay problema que el usuario mande datos para estos campos 
		params.require(:article).permit(:title,:body)
	end




end