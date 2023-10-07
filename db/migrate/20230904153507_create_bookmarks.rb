class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
    t.references :user
    t.references :post
      t.timestamps
    end

  end
end
