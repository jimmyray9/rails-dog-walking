class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.datetime :date_time
      t.string :address
      t.integer :duration
      t.integer :price
      t.string :description
      t.references :user, foreign_key: true
      t.references :dog, foreign_key: true

      t.timestamps
    end
  end
end
