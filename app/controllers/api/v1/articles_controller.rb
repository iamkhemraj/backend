class Api::V1::ArticlesController < ApplicationController
  def index
    #Display all record..
    articles = Article.all
    render json: articles, status: 200
  end

  def show
    #Get data by id.. 
    articles = Article.find_by(id: params[:id]);
    if articles
      render json: articles, status:200
      
    else
      render json:'Article not found';
    end

  end

  def create
    #Create user..
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article, status: 200  # Mistake: Missing colon after "status"
    else
      render json: {
       error: "there is some error"  # Mistake: Using colon instead of hash rocket
      }  
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article
      if article.update(title: params[:title], body: params[:body], author: params[:author])
        render json: { message: "Data updated successfully!" }, status:200
      else
        render json: { error: "Record could not be updated" }, status: 500
      end
    else
      render json: { error: "Record not found" }, status: 500
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article.destroy
      render json:{
        message:'Record delete successfully'
      }
    else{
      render json:{
        error:'Record does not delete'
      }
    }
    end

  private
  def arti_params
    params.require(:article).permit(  # Mistake: Using square brackets instead of parentheses
      :title,
      :body,
      :author
    )
  end
end
