class AddAttachmentToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :attachment, :string
  end
end
