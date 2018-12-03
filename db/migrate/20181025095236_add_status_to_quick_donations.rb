class AddStatusToQuickDonations < ActiveRecord::Migration[5.1]
  def change
    add_column :quick_donations, :status, :string
    add_column :quick_donations, :channel, :string
    add_column :quick_donations, :reference, :string
    add_column :quick_donations, :gateway_response, :string
    add_column :quick_donations, :currency, :string
  end
end
