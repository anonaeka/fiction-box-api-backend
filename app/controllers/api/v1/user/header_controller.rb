class Api::V1::User::HeaderController < Api::AppController
    before_action :set_current_user_from_header

def set_current_user_from_header
    auth_header = request.headers["Authorization"]
        raise AKAuthenticationError.new("No token") if auth_header.blank?
        bearer = auth_header.split.first
        raise AKAuthenticationError.new("Bad format") if bearer != "Bearer"
        jwt = auth_header.split.last
        raise AKAuthenticationError.new("Bad format") if jwt.blank?
        key = Rails.application.secret_key_base
        decoded = JWT.decode(jwt, key, 'HS256')
        payload = decoded.first
        if payload.blank? || payload["auth_token"].blank?
        raise AKAuthenticationError.new("Bad token")
    end
    @current_user = User.find_by_auth_token(payload["auth_token"])
    raise AKAuthenticationError.new("Bad token") if @current_user.blank?
end

    private
    def rescue_unauthorized(err)
        render json: {success: false, error: err}, status: :unauthorized
    end
end