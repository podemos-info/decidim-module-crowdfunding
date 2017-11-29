# frozen_string_literal: true

require 'spec_helper'

module Census
  module API
    describe Totals do
      let(:amount) { 50 }
      context 'User totals' do
        let(:result) { ::Census::API::Totals.user_totals(1) }

        context 'Error response' do
          before do
            stub_totals_request_error
          end

          it 'Is nil' do
            expect(result).to be_nil
          end
        end

        context 'API down' do
          before do
            stub_totals_service_down
          end

          it 'Is nil' do
            expect(result).to be_nil
          end
        end

        context 'API up' do
          before do
            stub_totals_request(amount)
          end

          it 'Returns the amount' do
            expect(result).to eq(amount)
          end
        end
      end

      context 'Campaign totals' do
        let(:result) { ::Census::API::Totals.campaign_totals(1) }

        context 'Error response' do
          before do
            stub_totals_request_error
          end

          it 'Is nil' do
            expect(result).to be_nil
          end
        end

        context 'API down' do
          before do
            stub_totals_service_down
          end

          it 'Is nil' do
            expect(result).to be_nil
          end
        end

        context 'API up' do
          before do
            stub_totals_request(amount)
          end

          it 'Returns the amount' do
            expect(result).to eq(amount)
          end
        end
      end

      context 'User campaign totals' do
        let(:result) { ::Census::API::Totals.user_campaign_totals(1, 1) }

        context 'Error response' do
          before do
            stub_totals_request_error
          end

          it 'Is nil' do
            expect(result).to be_nil
          end
        end

        context 'API down' do
          before do
            stub_totals_service_down
          end

          it 'Is nil' do
            expect(result).to be_nil
          end
        end

        context 'API up' do
          before do
            stub_totals_request(amount)
          end

          it 'Returns the amount' do
            expect(result).to eq(amount)
          end
        end
      end
    end
  end
end