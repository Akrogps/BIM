class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :cloudinary_url
      t.boolean :main, default: false
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
