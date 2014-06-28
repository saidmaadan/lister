class User < ActiveRecord::Base
  has_secure_password
  has_many :listings, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :enquiries, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :name, presence: true
  validates :email, presence: true,                   
                  format: /\A\S+@\S+\z/,
                  uniqueness: { case_sensitive: false }

   validates :password, length: { minimum: 8, allow_blank: true }
   validates :username, presence: true,
                     format: /\A[A-Z0-9]+\z/i,
                     uniqueness: { case_sensitive: false }




	has_attached_file :avatar, styles: {
    :small => "200x150>", :medium => "300x200>",
    :large => "500x500>", :thumb => "100x100>"
  }, :default_url => "/:style/mks7.jpg"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
   

   def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email_or_username, password)
    user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)
    user && user.authenticate(password)
  end

  def average_stars
    reviews.average(:stars)
  end
  
  def recent_reviews
    reviews.order('created_at desc').limit(3)
  end
end
