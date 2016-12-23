class ArticlesController < ApplicationController

	#GET /articles
	def index
		# Obtienen todos los registros
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		# Encuentra un registro por su id
		@article = Article.find(params[:id])
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	#POST /articles
	def create
		@article = Article.new(title: params[:article][:title], 
													 body: params[:article][:body])
		if @article.save 
			redirect_to @article
		else
		 	render :new
		end
	end

	#GET /articles/new
	def destroy
		# Primero buscar el artículo que el usuario quiere eliminar
		@article = Article.find(params[:id])
		# Segundo lo destruimos
		@article.destroy
		# Redirigir a la lista de artículos
		redirect_to articles_path

	end






end