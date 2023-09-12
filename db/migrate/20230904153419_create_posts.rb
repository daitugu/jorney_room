class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
    t.integer :user_id
    t.integer :tag_id
    t.text :thoughts
    t.string :location
    t.integer :lodging_fee
    t.string :room_type
      t.timestamps
    end
    add_index :posts, :user_id,                unique: true
    add_index :posts, :tag_id,                unique: true
  end
end
