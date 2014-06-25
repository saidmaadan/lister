class Listing < ActiveRecord::Base

	has_attached_file :upload, styles: {
    :small => "200x150>", :medium => "300x200>",
    :large => "500x500>", :thumb => "100x100>"
  }, :default_url => "/:style/mks7.jpg"

  validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/
# 	has_attached_file :upload, styles: {
#     :small => "200x150>", :medium => "300x200>",
#     :large => "500x500>", :thumb => "100x100>"},
#     :storage => :s3,
#     :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
#     validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/

#   def s3_credentials
#     {:bucket => "saidmfola", :access_key_id => "AKIAIHKZTDWOW7I433ZQ", :secret_access_key => "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"}
#   end
end
