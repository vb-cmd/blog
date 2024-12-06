module Api::V1
  class ArticlesController < BaseController
    skip_before_action :render_unauthorized, only: %i[index show destroy]
    before_action :set_article, only: %i[show update destroy]

    def index
      @articles = Article.latest(params[:page] || 1, 10)
    end

    def show; end

    def create
      @article = Article.new(article_params)

      if @article.save
        render :show, status: :created, article: @article
      else
        render_message(@article.errors.full_messages, :unprocessable_entity)
      end
    end

    def update
      if @article.update(article_params)
        render :show, status: :ok, location: { article: @article }
      else
        render_message(@article.errors.full_messages, :unprocessable_entity)
      end
    end

    def destroy
      @article.destroy!

      render_message(['Article was successfully destroyed.'])
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article)
            .permit(:title, :body, :published)
            .merge(user: current_user)
    end
  end
end
