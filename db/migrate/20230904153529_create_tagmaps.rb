class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
    t.integer :user_id
    t.integer :post_id
      t.timestamps
    end
    add_index :tagmaps, :user_id,                unique: true
    add_index :tagmaps, :post_id,                unique: true
  end
end
