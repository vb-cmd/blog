module Api::V1::Articles
  class SearchController < Api::V1::BaseController
    skip_before_action :render_unauthorized, only: %i[index]

    def index
      @articles = params[:query].blank? ? [] : Article.search(params_query)
    end

    private

    def params_query
      {
        title_cont: params[:query],
        published_eq: true
      }
    end
  end
end
