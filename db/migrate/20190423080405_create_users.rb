class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.boolean :is_walker
      t.string :name
      t.integer :zip_code
      t.string :phone_number
      t.integer :walker_age
      t.string :walker_description
      t.string :walker_img
      t.integer :walker_rating
      t.string :walker_price
      t.string :token
      t.string :openid

      t.timestamps
    end
  end
end
