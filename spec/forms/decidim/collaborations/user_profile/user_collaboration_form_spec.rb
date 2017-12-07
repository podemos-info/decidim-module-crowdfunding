# frozen_string_literal: true

require 'spec_helper'

module Decidim
  module Collaborations
    module UserProfile
      describe UserCollaborationForm do
        let(:collaboration) { create(:collaboration) }

        let(:current_user) { create(:user, organization: collaboration.organization) }
        let(:amount) { ::Faker::Number.number(4) }
        let(:frequency) { 'punctual' }
        let(:user_annual_accumulated) { 0 }
        let(:attributes) do
          {
            amount: amount,
            frequency: frequency
          }
        end

        let(:context) do
          {
            current_organization: collaboration.organization,
            current_feature: collaboration.feature,
            current_user: current_user,
            collaboration: collaboration
          }
        end

        subject do
          Decidim::Collaborations::UserProfile::UserCollaborationForm
            .from_params(attributes)
            .with_context(context)
        end

        before do
          stub_totals_request(user_annual_accumulated)
        end

        it { is_expected.to be_valid }

        context 'amount' do
          context 'is missing' do
            let(:amount) { nil }
            it { is_expected.not_to be_valid }
          end

          context 'is zero' do
            let(:amount) { 0 }
            it { is_expected.not_to be_valid }
          end

          context 'is a negative number' do
            let(:amount) { -1 }
            it { is_expected.not_to be_valid }
          end

          context 'is not an integer' do
            let(:amount) { 1.01 }
            it { is_expected.not_to be_valid }
          end

          context 'it is bellow the minimum valid' do
            let(:amount) { collaboration.minimum_custom_amount - 1 }
            it { is_expected.not_to be_valid }
          end

          context 'it puts the accumulated annual after the limit' do
            let(:user_annual_accumulated) { Decidim::Collaborations.maximum_annual_collaboration }
            it { is_expected.not_to be_valid }
          end
        end

        context 'when frequency is missing' do
          let(:frequency) { nil }
          it { is_expected.not_to be_valid }
        end
      end
    end
  end
end
