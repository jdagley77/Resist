# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Issue.destroy_all
Comment.destroy_all
Payment.destroy_all

issues = ["Marijuana Should be a Medical Option", "Golf is a Sport, Vote yes on Golf", "Lower the Drinking Age to 18", "Ban Unnecessary Diving in Soccer", "Enforce Mandatory Dog Leash Laws in Public Parks", "Penalize Unnecessary Honking on the Road", "Raise the Tax on Sugary Drinks", "Save Australia's Sharks", "Ban Tackling in the NFL"]

issues.each do |issue|
  Issue.create({
    title: issue, 
    description: Faker::Lorem.paragraph(2),
    user_id: 1
    })
end

10.times do
  issue = Issue.all.sample
  issue.payments.create({
    amt: Faker::Number.decimal(2),
    status: 'sent',
    issue_id: issue.id,
    user_id: 1
    })
end