class Api::V1::User::UsersController < Api::V1::User::HeaderController
  before_action :set_current_user_from_header, only: [ :get_user, :manage_user , :manage_user_update, :sign_out]
  before_action :user_update, only: [:manage_user_update]
  before_action :set_user, only: [:manage_user_update]
  
  def sign_up
    user = User.new(user_params)
    if user.save
      render json: { success: true }, status: :created
    else
      render json: { success: false, errors: user.errors.as_json}, status: :bad_request
    end
  end

  def sign_in
    user = User.find_by_email(params[:user][:email])
    raise AKError.new("Invalid email") if user.blank?
    if user.valid_password?(params[:user][:password])
      render json: {success: true, username: user.username, jwt: user.jwt(3.days.from_now)}, status: :created
    else
      raise AKAuthenticationError.new("Invalid email or password")
    end
  end

  def sign_out
  end

  def manage_user
    render json: { success: true, user: @current_user.as_json_for_manage }
  end

  def get_user
    render json: { success: true, user: @current_user.as_profile_json }
  end


  def manage_user_update
    if @user.update(user_update)
      render json: @user.as_json
      else
      render json: @user.errors, status: :unprocessable_entity
  end
  end


  private

  def set_user
    @user = @current_user
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def user_update
    params.require(:user).permit(:email, :username, :password, :bio)
  end
end

