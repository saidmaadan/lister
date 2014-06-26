class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true,                   
                  format: /\A\S+@\S+\z/,
                  uniqueness: { case_sensitive: false }

   validates :password, length: { minimum: 10, allow_blank: true }


	has_attached_file :avatar, styles: {
    :small => "200x150>", :medium => "300x200>",
    :large => "500x500>", :thumb => "100x100>"
  }, :default_url => "/:style/mks7.jpg"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
   

   def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email, password)
  	user = User.find_by(email: email)
  	user && user.authenticate(password)
  end
end
