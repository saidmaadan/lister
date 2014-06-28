class AddWepayToListings < ActiveRecord::Migration
  def change
    add_column :listings, :wepay_access_token, :string
    add_column :listings, :wepay_account_id, :integer
  end
end
