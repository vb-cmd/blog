module Api::V1::Articles
  class LikesController < Api::V1::BaseController
    skip_before_action :render_unauthorized, only: %i[index]
    before_action :set_article

    def index; end

    def create
      render :index unless @article.can_like?(current_user)

      like = @article.likes.new(like_params)

      if like.save
        render(:index, status: :created)
      else
        render_message(like.errors.full_messages, :unprocessable_entity)
      end
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end

    def like_params
      params.require(:like)
            .permit(:rating)
            .merge(user: current_user)
    end
  end
end
