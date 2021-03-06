class Listing < ActiveRecord::Base
	belongs_to :user

	has_attached_file :upload, styles: {
    :small => "200x200>", :medium => "300x300>",
    :large => "600x500>", :thumb => "100x100>"
  }, #:default_url => "/:style/mks7.jpg"

    :storage => :s3,
    :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
    validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/

  def s3_credentials
     {
        :bucket => ENV['AWS_BUCKET'],
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
    
  end
  extend FriendlyId
  friendly_id :slug_listings, use: :slugged
  searchkick
  # self.per_page = 10
  
  def slug_listings
    [
      :title,
      [:title, :accomodate],
      [:title, :accomodate, :home_type,],
      [:title, :accomodate, :home_type, :address],
      [:title, :accomodate, :home_type, :address, :pricing],
      [:title, :accomodate, :home_type, :address, :pricing, :apartment_type],
      [:title, :accomodate, :home_type, :address, :pricing, :apartment_type, :contact_name],
      [:title, :accomodate, :home_type, :address, :pricing, :apartment_type, :contact_name, :bedroom ]
    ]
  end

  validates :title, :address, :bedroom, :bathroom, :contact_name, :phone, presence: true
  validates :summary, length: { minimum: 25 }
  validates :pricing, numericality: { greater_than_or_equal_to: 0 }

  APARTMENT_TYPE = ['Apartment', 'Entire House', 'Shared Room', 'Private room', 'Other']
  validates :apartment_type, inclusion: { in: APARTMENT_TYPE }

  USER_TYPE = ['MANAGEMENT COMPANY', 'OWNER', 'AGENCY', 'BROKER', 'TENANT']
  validates :user_type, inclusion: { in: USER_TYPE } 

  has_many :enquiries, dependent: :destroy

  has_many :categorizations, dependent: :destroy
  has_many :amenities, through: :categorizations
  
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  
#   def self.search(params)
#   tire.search(load: true) do
#     query { string params[:query], default_operator: "AND" } if params[:query].present?
#     filter :range, published_at: {lte: Time.zone.now}
#   end
# end

  def self.recently_added
    order('created_at desc')
  end
  def should_generate_new_friendly_id?
    new_record?
  end

end
