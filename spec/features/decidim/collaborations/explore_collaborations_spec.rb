# frozen_string_literal: true

require 'spec_helper'

describe 'Explore collaborations', type: :feature do
  include_context 'feature'
  let(:manifest_name) { 'collaborations' }

  let(:collaborations_count) { 5 }
  let!(:collaborations) do
    create_list(:collaboration, collaborations_count, feature: feature)
  end

  before do
    stub_totals_request(0)
  end

  context 'index' do
    it 'shows all collaborations for the given process' do
      visit_feature

      collaborations.each do |collaboration|
        expect(page).to have_selector("#collaboration-#{collaboration.id}-item")
        expect(page).to have_content(translated(collaboration.title))
      end
    end
  end

  context 'filtering' do
    it 'allows searching by text' do
      visit_feature

      within '.filters' do
        fill_in :filter_search_text, with: translated(collaborations.first.title)

        # The form should be auto-submitted when filter box is filled up, but
        # somehow it's not happening. So we workaround that be explicitly
        # clicking on "Search" until we find out why.
        find('.icon--magnifying-glass').click
      end

      expect(page).to have_css('.card--list__item', count: 1)
      expect(page).to have_content(translated(collaborations.first.title))
    end
  end
end