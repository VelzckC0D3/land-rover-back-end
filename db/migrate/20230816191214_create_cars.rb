class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.string :front_image
      t.string :back_image
      t.string :interior_image

      t.timestamps
    end
  end
end
