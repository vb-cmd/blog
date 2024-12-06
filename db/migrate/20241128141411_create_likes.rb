class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.integer :rating, null: false, default: 1
      t.references :article, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
