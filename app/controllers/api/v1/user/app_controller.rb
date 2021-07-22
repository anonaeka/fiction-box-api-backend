class Api::V1::User::AppController < Api::AppController
before_action :set_current_user_from_sites

    def current_user(auth = true)
        raise AKAuthenticationError.new("Invalid Token") if auth && @current_user.blank?
        @current_user
    end

    def set_current_user_from_sites
        auth_sites = request.headers['auth-token']
        jwt = auth_sites.split(" ").last rescue nil
        results = JWT.decode(jwt, Rails.application.secret_key_base, true, { algorithm: "HS256" })
        payload = results.first rescue nil
        @current_user = User.find_by_auth_token(payload["auth_token"]) rescue nil
    end
end