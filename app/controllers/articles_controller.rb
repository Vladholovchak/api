class ArticlesController < ApplicationController
  def index
    articles = Article.recent.
    page(params[:page]).
    per(params[:per_page])
    render json: articles
  end

  def show
    render json: 'article 1'
  end
end
