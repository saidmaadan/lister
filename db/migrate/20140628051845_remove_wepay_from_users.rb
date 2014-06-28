class RemoveWepayFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :wepay_access_token, :string
    remove_column :users, :wepay_account_id, :integer
  end
end
