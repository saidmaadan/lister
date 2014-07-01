# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = ["HIGH RISE", "LOW RISE ", "DISABILITY ACCESS", "DOORMAN", "ELEVATOR", "WALKUP", "HEALTH CLUB", "PARKING LOT", "LAUND ROMAT", "GARAGE", "COVERED PARKING", "STREET PARKING", "NEAR BUS STOP", "NEAR SUBWAY", "ELECTRONIC SECURITY", "SWIMMING POOL", "WIRELESS INTERNET", "INTERNET"]
names.each { |name| Amenity.create!(name:name) }