class AddChannelToDonations < ActiveRecord::Migration[5.1]
  def change
    add_column :donations, :channel, :string
    add_column :donations, :reference, :string
    add_column :donations, :gateway_response, :string
    add_column :donations, :currency, :string
    add_column :donations, :status, :string
  end
end
