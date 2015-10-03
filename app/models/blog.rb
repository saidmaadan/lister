class Blog < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { minimum: 20 }
	validates :user_id, :title, presence: true

  extend FriendlyId
  friendly_id :slug_blogs, use: :slugged
  searchkick
  # self.per_page = 10
  
  def slug_blogs
    [
      :title,
      [:title, :user_id]
    ]
  end
  def should_generate_new_friendly_id?
    new_record?
  end
end
