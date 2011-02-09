puts 'CLEAR THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system./}.each(&:drop)
puts 'CREATE THE ROOT USER'
user = User.create!(
  :name => 'admin user', :email => 'gautam.chekuri@gmail.com',
  :password => 'letmein', :password_confirmation => 'letmein'
)
puts 'ROOT USER CREATED: ' << user.name
