class CreateCatRental < ActiveRecord::Migration[6.0]
  def change
    create_table :cat_rentals do |t|
      t.integer :cat_id, null:false
      t.date :start, null:false
      t.date :end, null:false
      t.string :status, null:false
    end
  end
end
