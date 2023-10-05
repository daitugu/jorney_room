class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
    t.references :user
    t.text :thoughts
    t.string :location
    t.integer :lodging_fee
    t.string :room_type
      t.timestamps
    end


  end
end
