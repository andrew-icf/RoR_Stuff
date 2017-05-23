# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'Street Cafes 2015-16.csv'))
# csv = CSV.foreach((Rails.root.join('lib', 'seeds', 'Street Cafes 2015-16.csv'), :headers => true, :encoding => 'ISO-8859-1')
CSV.foreach(Rails.root.join('lib', 'seeds', 'Street Cafes 2015-16.csv'), :headers => true) do |row|
  t = StreetCafe.new
  t.cafe_name = row['Cafe/Restaurant Name']
  t.street_address = row['Street Address']
  t.post_code = row['Post Code']
  t.number_of_chairs = row['Number of Chairs']
  t.save!
end
