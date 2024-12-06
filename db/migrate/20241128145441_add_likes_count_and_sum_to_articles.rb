class AddLikesCountAndSumToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :likes_count, :integer, null: false, default: 0
    add_column :articles, :likes_sum, :integer, null: false, default: 0
  end
end
