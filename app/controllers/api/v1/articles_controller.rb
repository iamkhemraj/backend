class Api::V1::ArticlesController < ApplicationController
  def index
    # Display all records
    articles = Article.all
    render json: articles, status: 200
  end

  def show
    # Get record data by id
    article = Article.find_by(id: params[:id])
    if article
      render json: article, status: 200
    else
      render json: { error: 'Record not found' }, status: 404
    end
  end

  def create
    # Create article
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article, status: 201
    else
      render json: { error: 'There is some error' }, status: 422
    end
  end

  def destroy
    # Delete article record
    article = Article.find_by(id: params[:id])
    if article
      if article.destroy
        render json: { message: 'Data deleted successfully!' }, status: 200
      else
        render json: { error: 'Record could not be deleted' }, status: 500
      end
    else
      render json: { error: 'Record not found' }, status: 404
    end
  end

  def update
    # Update article data
    article = Article.find_by(id: params[:id])
    if article
      if article.update(title: params[:title], body: params[:body], author: params[:author])
        render json: { message: 'Data updated successfully!' }, status: 200
      else
        render json: { error: 'Record could not be updated' }, status: 500
      end
    else
      render json: { error: 'Record not found' }, status: 404
    end
  end

  private

  def arti_params
    params.require(:article).permit(
      :title,
      :body,
      :author
    )
  end
end
