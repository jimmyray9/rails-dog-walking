class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :type
      t.references :user_id, foreign_key: true

      t.timestamps
    end
  end
end
