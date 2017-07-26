class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :text
      t.references :product

      t.timestamps
    end
  end
end
