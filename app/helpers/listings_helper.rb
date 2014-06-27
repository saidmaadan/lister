module ListingsHelper
	def format_price(listing)
		number_to_currency(listing.pricing)
	end
end