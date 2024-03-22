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
    articles = Article.find_by(id: params[:id]);
    if articles
      articles(title: arti_params[:title], body: arti_params[:body], author: arti_params[:author]);
      render json: "Update record successfully!"
    else
      render json:{
        error:"Record does not update"
      }
    end

  end

  def destroy
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
