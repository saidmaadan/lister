class AddAttachmentUploadToListings < ActiveRecord::Migration
  def self.up
    change_table :listings do |t|
      t.attachment :upload
    end
  end

  def self.down
    drop_attached_file :listings, :upload
  end
end
