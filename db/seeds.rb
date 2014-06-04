require 'faker'

# Create Users
# 5.times do
#   user = User.new(
#     name:     Faker::Name.name,
#     email:    Faker::Internet.email,
#     password: Faker::Lorem.characters(10)
#   )
#   user.skip_confirmation!
#   user.save
# end
# users = User.all

# Note: by calling `User.new` instead of `create`,
# we create an instance of User which isn't immediately saved to the database.

# The `skip_confirmation!` method sets the `confirmed_at` attribute
# to avoid triggering an confirmation email when the User is saved.

# The `save` method then saves this User to the database.

User.destroy_all
#Topic.destroy_all
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

10.times do 
  post_user = users.shuffle.first
  post_user.posts.create(title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph)
end

200.times do
  post = Post.all.shuffle.first
  post.comments.create(body: Faker::Lorem.paragraph)
end

User.first.update_attributes(
   email: 'youremail.com',
   password: 'helloworld',
 )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"