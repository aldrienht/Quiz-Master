FactoryBot.define do
  factory :admin, class: User do
    fullname Faker::Name.name
    username 'admin'
    password 'admin'
    password_confirmation 'admin'
    email Faker::Internet.email
    role 'admin'
    activated true
  end

  factory :teacher, class: User do
    fullname Faker::Name.name
    username 'teacher'
    password 'teacher'
    password_confirmation 'teacher'
    email Faker::Internet.email
    role 'teacher'
    activated true
  end

  factory :student, class: User do
    fullname Faker::Name.name
    username 'student'
    password 'student'
    password_confirmation 'student'
    email Faker::Internet.email
    role 'student'
    activated true
  end

  factory :invalid_user, class: User do
    fullname ''
    username ''
    password ''
    password_confirmation ''
    email ''
    role ''
    activated ''
  end

  factory :in_active_user, class: User do
    fullname 'InActive'
    username 'inactive'
    password 'inactive'
    password_confirmation 'inactive'
    email 'inactive@yahoo.com'
    role 'teacher'
    activated false
  end
end
