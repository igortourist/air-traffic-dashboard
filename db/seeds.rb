# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  User.create(username: 'admin', password: 'admin', password_confirmation: 'admin')

  7.times do
    Plane.create(model: 'Boeing 737-300', status: 'pending')
  end