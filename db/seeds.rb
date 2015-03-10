10.times do
  puts "making a user"
  user = FactoryGirl.create :user
  puts user.id
  puts "giving them 3 outfits"
  3.times do
    outfit = FactoryGirl.create :outfit, :with_hashtags, user: user
    puts outfit
    FactoryGirl.create :article, outfit: outfit
  end
  puts "*" * 100
end

outfits = Outfit.all
outfits.each do |outfit|
  2.times do
  puts "for each outfit"
    puts "making 2 ratings"
    n = User.count - 1
    id = rand(1..n)
    new_user = User.find(n)
    outfit.ratings.create(user: new_user, comment: Faker::Hacker.say_something_smart, stars: 3)
  end
  2.times do
    puts "making rating with stars only"
    n = User.count - 1
    id = rand(1..n)
    new_user = User.find(n)
    outfit.ratings.create(user: new_user, stars: 2)
  end
  puts "*" * 100
end


