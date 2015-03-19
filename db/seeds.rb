ArticleType.create(type_desc: "Blouse")
ArticleType.create(type_desc: "Necklace")
ArticleType.create(type_desc: "Jeans")
ArticleType.create(type_desc: "Pants")
ArticleType.create(type_desc: "Shoes")
ArticleType.create(type_desc: "Bracelet")
ArticleType.create(type_desc: "Watch")
ArticleType.create(type_desc: "Dress")
ArticleType.create(type_desc: "Wedges")
ArticleType.create(type_desc: "Sandals")
ArticleType.create(type_desc: "Sunglasses")
ArticleType.create(type_desc: "Rings")
ArticleType.create(type_desc: "Sweater")
ArticleType.create(type_desc: "Jacket")
ArticleType.create(type_desc: "Boots")
ArticleType.create(type_desc: "Lipstick")
ArticleType.create(type_desc: "Suit")
ArticleType.create(type_desc: "Shirt")
ArticleType.create(type_desc: "Belt")
ArticleType.create(type_desc: "Blazer")
ArticleType.create(type_desc: "Purse")
ArticleType.create(type_desc: "Bag")
ArticleType.create(type_desc: "Shorts")
ArticleType.create(type_desc: "Scarf")
ArticleType.create(type_desc: "Skirt")
ArticleType.create(type_desc: "Earrings")
ArticleType.create(type_desc: "Vest")
puts "*" * 100
puts "Article Types Created"
puts 
puts


puts "*" * 100
puts "making default user, login with user@user.com, pwd is user"
User.create(username: 'user', email: 'user@user.com', password: 'user')
puts "making seed users"
20.times do
  puts "making a user"
  user = User.create(username: Faker::Internet.user_name, email: Faker::Internet.free_email, password: Faker::Internet::password(8))
  puts "#{user.username} created"
  puts "*" * 100
end

require 'csv'
puts "*" * 100
puts "*" * 100
puts
puts
puts "importing outfits csv"
puts
CSV.foreach('db/import_outfits.csv', :headers => true) do |row|
	Outfit.create(image_url: row['image_url'], user_id: row['user_id'], title: row['title'], caption: row['caption'], gender: row['gender'] )
	# p row['id']

end
puts

puts "*" * 100
puts 'finished importing csv'
puts "*" * 100
puts "*" * 100
puts
puts "users are rating the outfits"
puts

def generate_comment
	pronouns =['your', 'that']
	nouns = ['look', 'style', 'outfit', 'getup']
	adjective = ['fabulous', 'great', 'horrible', 'fantastic', 'wretched', 'glamorous']
	"#{pronouns.sample} #{nouns.sample} is #{adjective.sample}"
end

def make_comment?
	random_boolean = [true, false].sample
end


users = User.all
users.each do |user|
	puts "#{user.username} is rating 10 outfits"
	not_users_outfits = Outfit.where.not(user_id: user.id)
	outfits = not_users_outfits.sample(10)
	outfits.each do |outfit|
		stars = rand(1..5)
		if make_comment?
			comment = generate_comment
			outfit.ratings.create(user: user, stars: stars, comment: comment)
		else
			outfit.ratings.create(user: user, stars: stars)
		end
	end
	puts "*" * 100
end