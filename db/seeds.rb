# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
38.times do |i|
  Link.create(title: "title #{i}",link: 'https://www.youtube.com/watch?v=yRmOWcWdQAo',review: 'abcdefg')
end