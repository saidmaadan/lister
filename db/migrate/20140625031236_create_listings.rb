class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :home_type
      t.decimal :accomodate
      t.datetime :address
      t.decimal :pricing
      t.string :title
      t.text :summary
      t.string :apartment_type
      t.string :image
      t.string :amenities
      t.decimal :bedroom
      t.decimal :bathroom
      t.string :contact_name
      t.string :company_name
      t.string :phone
      t.string :website_url
      t.string :user_type
      t.text :info

      t.timestamps
    end
  end
end
