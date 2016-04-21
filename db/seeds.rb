# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


qone = Question.create([{ask: "Where did you meet this person (so we can send them a reminder)?"}])
qtwo = Question.create([{ask: "What did you like the most about this person?"}]) 