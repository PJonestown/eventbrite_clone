User.create(username: 'virginia_woolf')
User.create(username: 'DFW')
User.create(username: 'thomas_pynchon')
User.create(username: 'vladimir_nabokov')
User.create(username: 'james_joyce')
User.create(username: 'earnest_hemingway')

Profile.create(user_id: 1, location: 'New York')
Profile.create(user_id: 2, location: 'New York')
Profile.create(user_id: 3, location: 'New York')
Profile.create(user_id: 4, location: 'Seattle')
Profile.create(user_id: 5, location: 'Austin, TX')
Profile.create(user_id: 6, location: 'New York')

Category.create(name: 'Technology')
Category.create(name: 'Politics/activism')
Category.create(name: 'Games')
Category.create(name: 'Sports')
Category.create(name: 'Hobbies')
Category.create(name: 'Other')

Group.create(name: 'Walks on the beach',
             description: 'We meet regularly every evening as if drawn by some need.',
             owner_id: 1, category_id: 6, is_private: false)
Group.create(name: 'Conspiracy club',
             description: 'Anything from bombs to underground post offices. You hide they seek.',
             owner_id: 3, category_id: 6, is_private: true)
Group.create(name: 'Mountain climbing meetup',
             description: 'The only real sport (except for racing and buullfighting of course)',
             owner_id: 6, category_id: 4, is_private: false)
Group.create(name: 'Tennis club',
             description: "Mandatory lemon pledge sunscreen. It’s Marlon Brando’s fault, Jim",
             owner_id: 2, category_id: 4, is_private: false)

Membership.create(member_id: 6, group_membership_id: 1)
Membership.create(member_id: 1, group_membership_id: 1)
Membership.create(member_id: 4, group_membership_id: 1)
Membership.create(member_id: 4, group_membership_id: 2)
Membership.create(member_id: 5, group_membership_id: 2)
Membership.create(member_id: 3, group_membership_id: 2)
Membership.create(member_id: 3, group_membership_id: 3)
Membership.create(member_id: 6, group_membership_id: 3)
Membership.create(member_id: 1, group_membership_id: 3)
Membership.create(member_id: 3, group_membership_id: 4)
Membership.create(member_id: 6, group_membership_id: 4)
Membership.create(member_id: 2, group_membership_id: 4)

Gathering.create(creator_id: 1, group_id: 1,
                 name: 'Waves appreciation', date: Time.zone.today + 1.year,
                 description: 'words')
Gathering.create(creator_id: 1, group_id: 1,
                 name: 'Sail to the lighthouse', date: Time.zone.today - 1.year,
                 description: 'more words')
Gathering.create(creator_id: 1, group_id: 1,
                 name: 'Painting lessons', date: Time.zone.today + 1.month,
                 description: 'He shivered; he quivered. All his vanity, all
                               his satisfaction in his own splendour, riding
                               fell as a thunderbolt.')

GatheringAttendance.create(attendee_id: 2, attended_gathering_id: 2)
GatheringAttendance.create(attendee_id: 3, attended_gathering_id: 2)
GatheringAttendance.create(attendee_id: 4, attended_gathering_id: 2)
GatheringAttendance.create(attendee_id: 6, attended_gathering_id: 3)
GatheringAttendance.create(attendee_id: 1, attended_gathering_id: 3)
GatheringAttendance.create(attendee_id: 4, attended_gathering_id: 3)

Moderation.create(moderator_id: 2, moderated_group_id: 1)
Moderation.create(moderator_id: 6, moderated_group_id: 1)

Event.new(name: 'One time only event',
          description: "Did I mention it's only one time and doesn't need a group?",
          date: Time.zone.today + 1.month,
          creator_id: 6)

Attendance.create(attendee_id: 6, attended_event_id: 1)
Attendance.create(attendee_id: 2, attended_event_id: 1)
Attendance.create(attendee_id: 4, attended_event_id: 1)
