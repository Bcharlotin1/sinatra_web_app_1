class UsersController < ApplicationController
   
    get '/signup' do 

        if !Helpers.is_logged_in?(session)
            erb :"/users/signup"
        else
    
          redirect "/posts"
        end
      end
    
      post '/signup' do 
        @exsisting_username = User.find_by(username: params[:username])
        @exsisting_email = User.find_by(email: params[:email])
    
        if params[:username]!= "" && params[:email] != "" && params[:password] != ""
            if !@exsisting_username
                if !@exsisting_email
                    @new_user = User.create(username: params[:username], email: params[:email], password: params[:password])
                    session[:user_id] = @new_user.id
         
                    redirect "/posts"
                else 
                     flash[:message] = "You already have an account, please login"
                    redirect to '/signup'
                end
            else 
              flash[:message] = "Username is taken"
                redirect to '/signup'  
            end 
        else
          flash[:message] = "Please enter all fields."
          redirect to '/signup'
        end

      end
    #------------------------------------------------
    get "/users/:slug" do
        if Helpers.is_logged_in?(session)
            @user = User.find_by_slug(params[:slug])
            erb :"/users/show_user_posts"
        else 
            redirect "/posts"
        end
    end
    #-------------------------------------------------
    get "/login"  do 
        if !Helpers.is_logged_in?(session)
            erb :"/users/login"
        else 
            redirect "/posts"
        end
    end

    post "/login" do 
    # binding.pry
         if params[:username] != "" && params[:password] != ""
            @user = User.find_by(username: params[:username], password_digest: params[:password] )
            if @user
                session[:user_id] = @user.id
                redirect '/posts'
            else
                flash[:message] = "Wrong username or password."
                redirect "/login"
            end
        else
            flash[:message] = "Please enter all fields."
            redirect "/login"
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            erb :"/users/logout"
        end
    end
    
    post '/logout' do
        session.clear
        redirect '/login'
    end
    

end

