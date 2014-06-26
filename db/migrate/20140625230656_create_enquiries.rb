class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :email
      t.text :comment
      t.references :listing, index: true

      t.timestamps
    end
  end
end
