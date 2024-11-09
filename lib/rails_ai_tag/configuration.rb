# lib/rails_ai_tag/configuration.rb
module RailsAiTag
  class Configuration
    attr_accessor :provider, :api_key

    def initialize
      @provider = :openai  # Default to OpenAI
      @api_key = ENV["OPENAI_API_KEY"]  # Can be set via environment variable or manually
    end
  end
end
