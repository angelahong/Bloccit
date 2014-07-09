require 'faker'

# Note: by calling `User.new` instead of `create`,
# we create an instance of User which isn't immediately saved to the database.

# The `skip_confirmation!` method sets the `confirmed_at` attribute
# to avoid triggering an confirmation email when the User is saved.

# The `save` method then saves this User to the database.

User.destroy_all
Topic.destroy_all
Post.destroy_all
Comment.destroy_all

me = User.new(
    name: "Angela Hong",
    password: "123123123",
    password_confirmation: "123123123",
    email: "angelahong85@gmail.com"
  )

me.skip_confirmation!
me.save

5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

# Create Topics
15.times do
  Topic.create(
    name:         Faker::Lorem.sentence,
    description:  Faker::Lorem.paragraph
  )
end
topics = Topic.all

10.times do 
  post_user = users.shuffle.first
  post_user.posts.create(topic: topics.sample, title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph)
end

# Create comments
200.times do
  post = Post.all.shuffle.first
  post.comments.create(body: Faker::Lorem.paragraph, user_id: users.shuffle.first.id)
end

# Create an admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)
admin.skip_confirmation!
admin.save

# Create a moderator
moderator = User.new(
  name:     'Moderator User',
  email:    'moderator@example.com', 
  password: 'helloworld',
  role:     'moderator'
)
moderator.skip_confirmation!
moderator.save

# Create a member
member = User.new(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld',
)
member.skip_confirmation!
member.save


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"