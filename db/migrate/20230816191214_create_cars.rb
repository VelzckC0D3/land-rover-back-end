class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.string :front_image
      t.string :semi_front_image
      t.string :side_image
      t.string :semi_back_image
      t.string :back_image
      t.string :color

      t.timestamps
    end
  end
end
