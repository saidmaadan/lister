def listing_attributes(overrides = {})
	{
		title: "Private Room",
    summary: "Full furnished private room",
    pricing: 850.00,
    address: '18st Austin TX!',
    home_type: 'apartment'
		}.merge(overrides)
end

def enquiry_attributes(overrides = {})
  {
    name: "Greg Brown", 
    email: "greg@gmail.com",
    comment: "I like to no more about this property"     
  }.merge(overrides)
end

def user_attributes(overrides = {})
  {
    name: "Agent1",
    email: "agent@example.com",
    password: "hidden",
    password_confirmation: "hidden"
  }.merge(overrides)
end