class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
    t.references :tag
    t.references :post
      t.timestamps
    end
    #add_index :tagmaps, :tag_id
    #add_index :tagmaps, :post_id
  end
end
