class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update]
    before_action :correct_user,   only: [:edit, :update]
	 def show
    # @user = User.find(current_user)
     @user = User.find(params[:id])

  end
  def new
  	 @user = User.new
  end

    def create
    @user = User.new(user_params)
    if @user.save
       log_in @user
      flash[:success] = "Welcome to the Sample App!"
    	 redirect_to @user
    	# redirect_to about_path
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
   def index
    @users = User.all
  end
 def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
       flash[:success] = "Profile updated"
      redirect_to @user
      # Handle a successful update.
    else
      render 'edit'
    end
  end


  private


    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

      def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url
        flash[:danger] = "Please log in." 
        
      end
    end
     def correct_user
      @user = User.find(params[:id])
      # redirect_to(root_url) unless @user == current_user
        redirect_to(root_url) unless current_user?(@user)
    end
  end
