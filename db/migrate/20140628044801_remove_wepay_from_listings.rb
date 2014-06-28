class RemoveWepayFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :wepay_access_token, :string
    remove_column :listings, :wepay_account_id, :integer
  end
end
