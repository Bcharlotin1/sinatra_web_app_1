class PostsController < ApplicationController
    
    get '/posts' do 
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @posts = Post.all
            erb :"/posts/posts"
        else
            redirect "/login"
        end
    end

    post "/posts" do 
       
        if params[:content] != ""
            @new_post = Post.create(content: params[:content])
            @user = User.find(params[:user_id])
            @user.posts << @new_post
            @user.save
            redirect "/posts"
        else
            redirect "/posts/new"
        end
     
    end

    get "/posts/new" do 
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :"/posts/new_post"
        else
            redirect "/login"
        end
    end

    get '/posts/:id/edit' do
        @post = Post.find(params[:id])
       
        if Helpers.is_logged_in?(session)
            if Helpers.current_user(session).id == @post.user_id
                erb  :"/posts/edit_post"
            else
                redirect "/posts"
            end
        else   
            redirect to "/login"
        end
    
    end

    patch '/posts/:id' do
        @post = Post.find_by_id(params[:id])
        
        if Helpers.is_logged_in?(session)
            if params[:content] != ""
                @post.update(content: params[:content])
                redirect "/posts/#{@post.id}"
            else
                flash[:message] = "Field can not be empty"
                redirect "/posts/#{@post.id}/edit"
            end
        else
            redirect "/login"
        end
    end

    get "/posts/:id" do
        @post = Post.find_by_id(params[:id]) 
        @user = User.find_by(id: @post.user_id)
        if Helpers.is_logged_in?(session)
            @post = Post.find_by_id(params[:id]) 
            erb :"/posts/show_posts"
        else
          redirect "/login"
        end
    end

    delete '/posts/:id' do
        @post = Post.find_by_id(params[:id])
        
        if Helpers.is_logged_in?(session)
            if Helpers.current_user(session).id == @post.user_id
                @post.delete
                redirect to '/posts'
            end
        else
            redirect "/login"
        end
    end

end