@sophie = User.create(:username => "SophieLove", :email => "SL@gmail.com", :password_digest => "test")
Post.create(content: "Hello My name is Sophie", user_id: @sophie.id)
Post.create(content: "I love to eat ramen", user_id: @sophie.id)

@lester = User.create(username: "Lester", email: "Lester@gmail.com", password_digest: "Lester")
Post.create(content: "Hello My name is Lester", user_id: @lester.id)
Post.create(content: "I like eggs", user_id: @lester.id)