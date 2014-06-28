class RemoveAddressFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :address, :datetime
  end
end
