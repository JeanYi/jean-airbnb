class UsersController < Clearance::BaseController
  if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:create, :new]
    skip_before_action :require_login, only: [:create, :new], raise: false
    skip_before_action :authorize, only: [:create, :new], raise: false
  else
    before_filter :redirect_signed_in_users, only: [:create, :new]
    skip_before_filter :require_login, only: [:create, :new], raise: false
    skip_before_filter :authorize, only: [:create, :new], raise: false
  end

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def create
    @user = user_from_params
    if @user.save
      sign_in @user
      redirect_to root_url 
    else
      render template: "users/new"
    end
  end

  def edit 
    @edit_user = User.find_by_id(params[:id])
    render template: "users/edit"
  end 

  def update 
    @edit_user = User.find_by_id(params[:id])
    if @edit_user.update_attributes(update_user_params)
    redirect_to root_url
    else 
      render template: "users/edit"
      flash[:unsuccessful_update] = "Please try again"
    end 
  end 

# PUT PRIVATE METHODS HERE # 
  private

  def avoid_sign_in
    warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
      "deprecated. Use `redirect_signed_in_users` instead. " +
      "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
      " or `skip_before_action :avoid_sign_in` as well"
    redirect_signed_in_users
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to Clearance.configuration.redirect_url
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :birthday, :image)
  end 

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
	  first_name = user_params.delete(:first_name)
	  last_name = user_params.delete(:last_name)
	  birthday = user_params.delete(:birthday)   
    role = user_params.delete(:role)
    image = user_params.delete(:image)

  Clearance.configuration.user_model.new(user_params).tap do |user|
	   user.email = email
	   user.password = password
	   user.first_name = first_name
	   user.last_name = last_name
	   user.birthday = birthday
     user.role = role 
     user.image = image 
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end