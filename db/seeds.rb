# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Issue.destroy_all
Comment.destroy_all
Payment.destroy_all

10.times do
  User.create({
    username: Faker::GameOfThrones.character,
    email: Faker::Internet.email,
    password: 'password'
    })
end

10.times do
  user = User.all.sample
  user.issues.create({
    title: Faker::Lorem.sentences(1),
    description: Faker::Lorem.sentences(3),
    user_id: user.id
    })
end

10.times do
  user = User.all.sample
  issue = Issue.all.sample
  issue.payments.create({
    amt: Faker::Number.decimal(2),
    status: 'sent',
    issue_id: issue.id,
    user_id: user.id
    })
end