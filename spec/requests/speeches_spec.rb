# frozen_string_literal: true

require 'rails_helper'

describe 'speeches' do
  context 'get /api/v1/speeches' do
    it 'return all speeches' do
      track = create(:track, title: "track A")
      section = create(:section, type_section: "morning", track: track)
      create(:speech, title: 'Um mundo sem StackOverflow', duration: 60, section: section)
      get '/api/v1/speeches'

      expect(response).to have_http_status(200)
      expect(response.body).to include('Um mundo sem StackOverflow')
      expect(response.body).to include('60')
      expect(response.body).to include('540')
      expect(response.body).to include('track A')
      expect(response.body).to include('morning')
    end
  end
  # context 'get /api/v1/project/:id' do
  #   it 'should be return a project' do
  #     project = create(:project, title: 'blog')

  #     get "/api/v1/projects/#{project.id}"

  #     expect(response).to have_http_status(200)
  #     expect(response.content_type).to include('application/json')
  #     expect(parsed_body[:title]).to eq('blog')
  #     expect(parsed_body[:remote]).to be true
  #   end
  # end
end
