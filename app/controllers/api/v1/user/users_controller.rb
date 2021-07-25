class Api::V1::User::UsersController < Api::AppController
  # before_action :set_user, only: [:manage_user]
  before_action :set_current_user_from_jwt, only: [:manage_user, :sign_out]

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
    if user.valid_password?(params[:user][:password])
      render json: {success: true, jwt: user.jwt(3.days.from_now)}, status: :created
    else
      render json: {success: false}, status: :unauthorized
    end
  end

  def sign_out
    @current_user.generate_auth_token(true)
    @current_user.save
    render json: {success: true}
  end

  def manage_user
    render json: { success: true, user: @current_user.as_json }
  end

  # def manage_user_update
  #   @current_user.user_update
  #   render json: user.as_json
  # end


  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def user_update
    params.require(:user).permit(:email, :username, :password, :bio)
  end
end

