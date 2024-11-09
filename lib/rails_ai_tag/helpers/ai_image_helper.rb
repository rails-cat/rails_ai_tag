# lib/rails_ai_tag/helpers/ai_image_helper.rb
require "httparty"

module RailsAiTag
  module Helpers
    module AiImageHelper
      def ai_image_tag(description, **options)
        image_url = generate_image(description)
        image_tag(image_url, alt: description, **options)
      end

      private

      def generate_image(description)
        case RailsAiTag.configuration.provider
        when :openai
          generate_image_openai(description)
        else
          raise NotImplementedError, "Provider #{RailsAiTag.configuration.provider} is not supported"
        end
      end

      def generate_image_openai(description)
        response = HTTParty.post("https://api.openai.com/v1/images/generations", {
          body: { prompt: description, n: 1, size: "512x512" }.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{RailsAiTag.configuration.api_key}"
          }
        })

        if response.code == 200
          response.parsed_response["data"].first["url"]
        else
          "/assets/default_image.png" # Fallback image
        end
      end
    end
  end
end
