Rails.configuration.to_prepare do
    class AKError < StandardError
    end

    class AKAuthenticationError < StandardError
    end
end