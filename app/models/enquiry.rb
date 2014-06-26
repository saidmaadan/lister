class Enquiry < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user

  # validates :name, :comment, presence: true

  # validates :email, format: { with: /(\S+)@(\S+)/ }
end
