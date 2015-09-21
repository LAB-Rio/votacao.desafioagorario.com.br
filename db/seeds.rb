# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'


CSV.foreach("#{Rails.root.join('db/sample/sampledata.csv')}", encoding: "utf8", row_sep: :auto) do |row|
  puts row 
  Proposal.create!({
    title: "#{row[11]}",
    fullname: "#{row[1]}",
    age: "#{row[3]}",
    gender: "#{row[2]}",
    district: "#{row[4]}",
    degree: "#{row[5]}",
    group: "#{row[6]}",
    facebook: "#{row[7]}",
    about: "#{row[8]}",
    reason: "#{row[9]}",
    video_url: "#{row[10]}",
    email: "#{row[12]}",
    phone: "#{row[13]}",
    zone: "#{row[14]}"
  })
end
