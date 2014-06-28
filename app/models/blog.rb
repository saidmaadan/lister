class Blog < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { minimum: 20 }
	validates :user_id, :title, presence: true
end
