class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sex, :string
    add_column :users, :birthdate, :datetime
    add_column :users, :phone_number, :string
    add_column :users, :where_you_live, :string
    add_column :users, :info, :text
    add_column :users, :school, :string
    add_column :users, :work, :string
    add_column :users, :marital_status, :string
    add_column :users, :video, :string
  end
end
