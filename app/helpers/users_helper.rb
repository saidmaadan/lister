module UsersHelper
	# def profile_image_for(user)
 #    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
 #    image_tag(url, alt: user.name)
 #  end

 def profile_image_for(user, options={})
  size = options[:size] || 80
  url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
  image_tag(url, alt: user.name)
end

  def delete_review_image
	   image_tag('trash.png', style: 'border: 0', :title => 'Delete Review')
	 end
 
 def format_average_stars(user)   
   if user.average_stars.nil?
     content_tag(:strong, 'No reviews')
   else
   	#"*" * user.average_stars.round
     pluralize(number_with_precision(user.average_stars, :precision => 1) , 'star')
   end
 end
end
