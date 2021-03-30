require './config/environment'

class ApplicationController < Sinatra::Base

  
  configure do
    #block above is a part of built-in settings that control whether features are enabled or not. In this case, we're enabling the sessions feature.
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    use Rack::Flash 
    set :session_secret, "secret"
    # is an encryption key that will be used to create a session_id
  end

  get "/" do
    erb :index
  end

end
