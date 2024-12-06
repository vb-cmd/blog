module Api::V1::Articles
  class CommentsController < Api::V1::BaseController
    skip_before_action :render_unauthorized, only: %i[index]
    before_action :set_article

    def index
      @comments = @article.newest_comments
    end

    def create
      @comment = @article.comments.new(comment_params)

      if @comment.save
        render partial: 'comment', locals: { comment: @comment }, status: :created
      else
        render_message(@comment.errors.full_messages, :unprocessable_entity)
      end
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment)
            .permit(:body)
            .merge(user: current_user)
    end
  end
end
