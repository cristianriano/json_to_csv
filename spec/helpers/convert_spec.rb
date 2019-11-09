# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ConvertHelper do
  class DummyClass
    include ConvertHelper

    attr_accessor :request
  end

  let(:instance) { DummyClass.new }

  describe '#items' do
    before do
      instance.request = OpenStruct.new(body: StringIO.new(body))
    end

    subject { instance.items }

    shared_examples 'invalid_request' do
      it 'raises error' do
        expect { subject }.to raise_error(expected_error)
      end
    end

    context 'when the body is not JSON' do
      let(:body) { 'invalid body' }
      let(:expected_error) { JSON::ParserError }

      it_behaves_like 'invalid_request'
    end

    context 'when the body is a valid JSON' do
      let(:body) { JSON.dump(payload) }

      context 'when the root item is not an array' do
        let(:payload) { { foo: 'bar' } }
        let(:expected_error) { ArgumentError }

        it_behaves_like 'invalid_request'
      end

      context 'when the root item is an array' do
        context 'when not every element is an object' do
          let(:payload) do
            [
              { foo: 'bar' },
              'I am a string'
            ]
          end
          let(:expected_error) { ArgumentError }

          it_behaves_like 'invalid_request'
        end

        context 'when every element is a JSON object' do
          let(:payload) do
            [
              { foo: 'bar' },
              { baz: 2 }
            ]
          end

          it 'returns correct items' do
            expect(subject.count).to eq 2
            expect(subject.first).to eq('foo' => 'bar')
            expect(subject.last).to eq('baz' => 2)
          end
        end
      end
    end
  end
end
