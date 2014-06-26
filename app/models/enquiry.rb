class Enquiry < ActiveRecord::Base
  belongs_to :listing

  validates :name, :comment, presence: true

  validates :email, format: { with: /(\S+)@(\S+)/ }
end
