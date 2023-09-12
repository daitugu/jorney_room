class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
    t.integer :post_id
    t.text :caption
      t.timestamps
    end
  end
end
