class AddColumnPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :is_opened, :boolean, default: false
  end
end
