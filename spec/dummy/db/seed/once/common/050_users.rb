# User #1
#
u = User.create(
  :username => 'user1',
  :email => 'user1@example.com',
  :password => 'password',
  :confirmed_at => Time.now,
)

UserProfile.create(
  :user => u,
  :forename => 'User',
  :surname => '#1'
)

UserPreference.create(
  :user => u,
  :key => 'colour',
  :value => 'blue'
)

UserPreference.create(
  :user => u,
  :key => 'theme',
  :value => 'default'
)

u.roles << Role.find_by_name('author')
u.roles << Role.find_by_name('editor')

# User #2
#
u = User.create(
  :username => 'user2',
  :email => 'user2@example.com',
  :password => 'password',
  :confirmed_at => Time.now,
)

UserProfile.create(
  :user => u,
  :forename => 'User',
  :surname => '#2'
)

UserPreference.create(
  :user => u,
  :key => 'colour',
  :value => 'red'
)

UserPreference.create(
  :user => u,
  :key => 'theme',
  :value => 'opaque'
)

u.roles << Role.find_by_name('guest')
