class Helpers 

    def self.current_user(sessions_hash)
        @id = sessions_hash[:user_id]
        if @id
          
            User.find_by(id: @id)
           
        end
    end

    def self.is_logged_in?(sessions_hash)
      !!sessions_hash[:user_id] # this is almost like an nd if satmenet,  to see if sessions exists,  returns true, if it exsits
        
        
    end
end