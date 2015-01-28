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
        @user.send_activation_email

       # UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
       
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
     # @users = User.all
       @users = User.paginate(:page => params[:page], :per_page => 5)
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
