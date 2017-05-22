# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
 #movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
 #Character.create(name: 'Luke', movie: movies.first)
100.times do |index|
	5.times do |index2|
	Humidity.create!(value: Faker::Number.normal(100,3.5),
             device_id: 1,
            created_at: index.days.ago)
		end
end
p "Created #{Humidity.count} Humidities"
#
# 100.times do |index|
#  	10.times do |index2|
#   	Temperature.create!(value: Faker::Number.normal(25,8),
#                   device_id: 5,
#     	            created_at: index.days.ago)
# 			end
# end
#
# p "Created #{Temperature.count} Temperatures"
#
# 50.times do |index|
#  	10.times do |index2|
#   	Carbondioxide.create!(value: Faker::Number.normal(70,15),
#                 device_id: 5,
#    	            created_at: index.days.ago)
# 			end
# end
# p "Created #{Carbondioxide.count} Carbondioxide"
#
# 8.times do |index|
#  	30.times do |index2|
#     Energy.create!(total: Faker::Number.normal(100,2),
#                 home_id: 1,
#    	            created_at: index.days.ago)
#     			end
# end
# p "Created #{Energy.count} Energy_Delta"
# 5.times do |index|
#  	2.times do |index2|
#   	Motion.create!(value: Faker::Number.digit,
#                 device_id: 1,
#    	            created_at: index.days.ago)
# 			end
# end
# p "Created #{Motion.count} motion"
