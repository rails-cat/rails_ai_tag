# frozen_string_literal: true

# lib/rails_ai_tag.rb
require "rails_ai_tag/version"
require "rails_ai_tag/configuration"
require "rails_ai_tag/helpers/ai_image_helper"

module RailsAiTag
  class Railtie < ::Rails::Railtie
    initializer "rails_ai_tag.helpers" do
      ActiveSupport.on_load(:action_view) do
        include RailsAiTag::Helpers::AiImageHelper
      end
    end
  end

  class << self
    attr_accessor :configuration
    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end