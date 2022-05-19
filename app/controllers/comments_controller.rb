# frozen_string_literal: true

class CommentsController < ApplicationController
  include Paginable

  skip_before_action :authorize!, only: [:index]
  before_action :load_article

  # GET /comments
  def index
    comments = paginate(@article.comments)
    render_collection(comments)
  end

  # POST /comments
  def create
    @comment = @article.comments.build(
      comment_params.merge(user: current_user)
    )
    @comment.save!
    render json: @comment, status: :created, location: @article
  rescue StandardError
    render json: @comment.errors, status: :unprocessable_entity
  end

  private

  def load_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def serializer
    CommentSerializer
  end
end
