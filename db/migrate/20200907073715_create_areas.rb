class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.string :name, default: "", null: false
      t.string :postal_code, default: "", null: false

      t.timestamps
    end
  end
end
