class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :model
      t.string :year
      t.string :price
      t.string :main_image
      t.string :side_image

      t.timestamps
    end
  end
end
