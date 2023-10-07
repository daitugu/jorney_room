class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
    t.references :post
    t.text :caption
      t.timestamps
    end
  end
end
