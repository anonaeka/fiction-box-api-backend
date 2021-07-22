class Api::AppController < ApplicationController
    rescue_from AKError, with: :handle_400
    rescue_from AKAuthenticationError, with: :handle_401

    def handle_400(exception)
        render json: { success: false, error: exception.message }, status: :bad_request and return
    end

    def handle_401(exception)
        render json: { success: false, error: exception.message }, status: :bad_request and return
    end
end