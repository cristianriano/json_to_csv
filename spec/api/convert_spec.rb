# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ConvertController do
  include Rack::Test::Methods

  subject { post '/', body, headers }

  let(:headers) { { 'Content-Type' => 'application/json' } }

  shared_examples 'invalid_request' do
    it 'returns 400 error' do
      expect(subject.status).to eq 400
      expect(subject.content_type).to include 'text/plain'
    end
  end

  context 'when there is no body' do
    let(:body) { '' }

    it_behaves_like 'invalid_request'
  end

  context 'when the body is not JSON' do
    let(:body) { 'item1,item2' }

    it_behaves_like 'invalid_request'
  end

  context 'when the body is a valid JSON' do
    let(:body) { JSON.dump(elements) }

    context 'when not every element is an object' do
      let(:elements) do
        [
          { a: 1 },
          'Jhon'
        ]
      end

      it_behaves_like 'invalid_request'
    end

    context 'when every element is valid' do
      shared_examples 'valid_request' do
        it 'returns correct data' do
          expect(subject.status).to eq 200
          expect(subject.content_type).to include 'text/csv'
          verify { subject.body }
        end
      end

      context 'empty array' do
        let(:elements) { [] }

        it_behaves_like 'valid_request'
      end

      context 'single element' do
        let(:elements) { [{ name: 'Jhon', age: 12 }] }

        it_behaves_like 'valid_request'
      end

      context 'multiple elements' do
        let(:elements) do
          [
            { a: 1, b: 2 },
            { name: 'Jhon', age: 12 }
          ]
        end

        it_behaves_like 'valid_request'
      end
    end
  end
end
