class ListingsController < ApplicationController
	def index
		@listings = Time.now
	end
end
