require 'csv'

filename = Rails.root.join('public/stops.csv')
raw_stops = CSV.read(filename, encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all)

raw_stops.each do |stop|
  stop_hash = stop.to_h
  Point.find_or_create_by(stib_id: stop_hash[:stop_id].to_i, name: stop_hash[:stop_name].downcase, parent_id: stop_hash[:parent_station])
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
