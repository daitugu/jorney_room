class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
    t.integer :user_id
    t.integer :post_id
    t.text :comment
      t.timestamps
    end
    add_index :comments, :user_id,                unique: true
    add_index :comments, :post_id,                unique: true
  end
end
