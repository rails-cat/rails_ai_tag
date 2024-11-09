# spec/helpers/ai_image_helper_spec.rb
require "rails_helper"
require "rails_ai_tag/helpers/ai_image_helper"

RSpec.describe RailsAiTag::Helpers::AiImageHelper do
  include RailsAiTag::Helpers::AiImageHelper

  before do
    RailsAiTag.configure do |config|
      config.provider = :openai
      config.api_key = "test_api_key"
    end
  end

  describe "#ai_image_tag" do
    let(:description) { "A futuristic cityscape at sunset" }

    context "when OpenAI is the provider" do
      before do
        RailsAiTag.configuration.provider = :openai
      end

      it "returns an image tag with the generated image URL" do
        allow(self).to receive(:generate_image_openai).and_return("https://example.com/generated_image.png")

        result = ai_image_tag(description)
        expect(result).to include("https://example.com/generated_image.png")
        expect(result).to include("alt=\"A futuristic cityscape at sunset\"")
      end
    end
  end
end

# spec/helpers/ai_image_helper_spec.rb
require "rails_helper"
require "rails_ai_tag/helpers/ai_image_helper"

RSpec.describe RailsAiTag::Helpers::AiImageHelper do
  include RailsAiTag::Helpers::AiImageHelper

  before do
    RailsAiTag.configure do |config|
      config.provider = :openai
      config.api_key = "test_api_key" # Mocked API key
    end
  end

  describe "#ai_image_tag" do
    let(:description) { "A futuristic cityscape at sunset" }

    context "when OpenAI is the provider" do
      before do
        RailsAiTag.configuration.provider = :openai

        # Mock the OpenAI API response
        stub_request(:post, "https://api.openai.com/v1/images/generations")
          .with(
            body: { prompt: description, n: 1, size: "512x512" }.to_json,
            headers: {
              'Content-Type' => 'application/json',
              'Authorization' => "Bearer test_api_key"
            }
          ).to_return(
            status: 200,
            body: { "data" => [{ "url" => "https://example.com/generated_image.png" }] }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it "returns an image tag with the generated image URL" do
        result = ai_image_tag(description)
        expect(result).to include("https://example.com/generated_image.png")
        expect(result).to include("alt=\"A futuristic cityscape at sunset\"")
      end
    end
  end
end
