# frozen_string_literal: true

require "decidim/dev"

ENV["ENGINE_NAME"] = File.dirname(__dir__).split("/").last

Decidim::Dev.dummy_app_path = File.expand_path(File.join("spec", "decidim_dummy_app"))

require "decidim/dev/test/base_spec_helper"

RSpec.configure do |c|
  c.include ActionView::Helpers::SanitizeHelper
  c.include ActionView::Helpers::NumberHelper
  c.include Decidim::Collaborations::Admin::CollaborationsHelper
end
