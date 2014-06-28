class Listing < ActiveRecord::Base
	belongs_to :use

	has_attached_file :upload, styles: {
    :small => "200x200>", :medium => "350x300>",
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

  validates :title, :address, :bedroom, :bathroom, :apartment_type, :contact_name, :phone, presence: true
  validates :summary, length: { minimum: 25 }
  validates :pricing, numericality: { greater_than_or_equal_to: 0 }

  has_many :enquiries, dependent: :destroy

  has_many :categorizations, dependent: :destroy
  has_many :amenities, through: :categorizations
  
  geocoded_by :address
  after_validation :geocode
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  reverse_geocoded_by :latitude, :longitude, :address => :location
  geocoded_by :address, :lookup => :yandex
  geocoded_by :address, :lookup => lambda{ |obj| obj.geocoder_lookup }

def geocoder_lookup
  if country_code == "RU"
    :yandex
  elsif country_code == "CN"
    :baidu
  else
    :google
  end
end

end