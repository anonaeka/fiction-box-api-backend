class Api::V1::User::SessionsController < Api::V1::User::AppController
  def sign_in
    user = User.find_by_email(params[:user][:email])
    raise AKError.new("Invalid Email") if user.blank?
    if user.valid_password?(params[:user][:password])
      render json: { success: true, user: user.as_json }
    else
      raise AKAuthenticationError.new("Invalid email or password")
    end
  end

  def sign_out
  end

  def me
  end
end
