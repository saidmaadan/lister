class MakeEnquiriesAJoinTable < ActiveRecord::Migration
  def up
    Enquiry.delete_all
    remove_column :enquiries, :name
    remove_column :enquiries, :email
    add_column    :enquiries, :user_id, :integer
  end
  
  def down
    Enquiry.delete_all
    remove_column :enquiries, :user_id
    add_column    :enquiries, :email, :string
    add_column    :enquiries, :name,  :string
  end
end

