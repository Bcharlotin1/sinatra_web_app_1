class User < ActiveRecord::Base
    has_secure_password
    belongs_to :user_profile
    has_many :posts
  
    def slug
      username.downcase.gsub(" ", "-")
    end
  
    def self.find_by_slug(slug) 
       User.all.find {|user| user.slug == slug}  
    end
  end