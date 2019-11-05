class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :description
      t.text :content
      t.string :website
      t.string :phone_number
      t.string :opening_hours
      t.string :price_indication
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
