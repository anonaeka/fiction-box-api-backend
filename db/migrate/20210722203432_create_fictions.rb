class CreateFictions < ActiveRecord::Migration[6.1]
  def change
    create_table :fictions do |t|
      t.string :name
      t.text :description
      t.text :article
      t.string :image_url
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
