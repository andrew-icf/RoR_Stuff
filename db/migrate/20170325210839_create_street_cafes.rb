class CreateStreetCafes < ActiveRecord::Migration[5.0]
  def change
    create_table :street_cafes do |t|
      t.string :cafe_name
      t.string :street_address
      t.string :post_code
      t.integer :number_of_chairs

      t.timestamps
    end
  end
end
