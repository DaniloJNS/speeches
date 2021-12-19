#bfrozen_string_literal: true

require 'rails_helper'
require 'json'

describe Api::V1::SpeechesController do
  context 'get /api/v1/speeches' do
    it 'return all speeches' do
      track = create(:track, title: 'track A')
      section = create(:section, type_section: 'morning', track: track)
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
  describe '#create' do
    context 'post /api/v1/speeches' do
      let(:file) { fixture_file_upload('case.txt') }

      it 'should be return a conference' do
        post '/api/v1/speeches', params: { file: file, format: 'json' }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(parsed_body).to eq(JSON.parse(open("#{Rails.root}/spec/support/api/case.json").read,
                                             symbolize_names: true))
      end
    end
  end
end
