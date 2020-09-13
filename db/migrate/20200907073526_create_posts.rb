class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :area_id, null: false
      t.string :title, null: false
      t.text :caption, null: false
      t.float :score, default: 0.0, null: false

      t.timestamps
    end
  end
end
