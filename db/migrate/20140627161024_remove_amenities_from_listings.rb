class RemoveAmenitiesFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :amenities, :string
  end
end
