def random_date
  rand(-3.months..8.months).ago
end

def random_user
  rand(1..20)
end

def random_category
  rand(1..6)
end

def random_group 
  rand(1..60)
end

20.times do
  User.create(username: Faker::Internet.user_name)
end

100.times do
  Event.create(name: Faker::Company.catch_phrase,
               description: Faker::Lorem.sentences(3),
               date: random_date,
               creator_id: random_user)
end

categories = ['Technology',
              'Politics/activism',
              'Games',
              'Sports',
              'Hobbies',
              'Other']

categories.each do |c|
  Category.create(name: c)
end

50.times do
  Group.create(name: Faker::Company.catch_phrase,
               description: Faker::Lorem.sentences(3),
               owner_id: random_user,
               category_id: random_category)
end

10.times do
  Group.create(name: Faker::Company.catch_phrase,
               description: Faker::Lorem.sentences(3),
               owner_id: random_user,
               category_id: random_category,
               is_private: true,
               restricted: true)
end

300.times do
  Membership.create(member_id: random_user,
                    group_membership_id: random_group)
end

Group.all.each do |g|
  15.times do
    Gathering.create(name: Faker::Company.catch_phrase,
                     description: Faker::Lorem.sentences(3),
                     creator_id: random_user,
                     group_id: g.id,
                     date: random_date)
  end
end

Gathering.all.each do |g|
  3.times do
    GatheringAttendance.create(attendee_id: random_user,
                               attended_gathering_id: g.id)
  end
end

Event.all.each do |e|
  10.times do
    Attendance.create(attendee_id: random_user,
                      attended_event_id: e.id)
  end
end

Group.all.each do |g|
  2.times do
    Moderation.create(moderator_id: random_user,
                      moderated_group_id: g.id)
  end
end

addressable = []

User.all.each do |n|
  addressable << n
end

Event.all.each do |n|
  addressable << n
end

Group.all.each do |n|
  addressable << n
end

Gathering.all.each do |n|
  addressable << n
end

addressable.each do |a|

  case rand(1..5)
    when 1
      loc = 'New York'
      lat =  40.7127837
      long = -74.0059413

    when 2
      loc = 'Chicago'
      lat = 41.8781136
      long = -87.6297982

    when 3 
      loc = 'Austin'
      lat =  30.267153
      long = -97.7430608

    when 4
      loc = 'Houston'
      lat = 29.7604267
      long = -95.3698028

    when 5
      loc = 'San Francisco'
      lat = 37.7749295
      long = -122.4194155
  end

  Address.create(addressable_id: a.id,
                 addressable_type: a.class,
                 location: loc,
                 latitude: lat,
                 longitude: long)
end
