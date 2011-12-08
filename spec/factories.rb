Factory.define :user do |user|
  user.name "Notna Woods"
  user.email "anton@kommingle.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
