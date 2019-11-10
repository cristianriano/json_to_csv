# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ConversorToCSV do
  subject(:csv) { described_class.new(items) }

  shared_examples 'correct_output' do
    it 'returns correct CSV' do
      expect { |b| csv.call(&b) }.to yield_successive_args(*expected_lines)
    end
  end

  context 'with empty items array' do
    let(:items) { [] }
    let(:expected_lines) { [] }

    it_behaves_like 'correct_output'
  end

  context 'with single items' do
    let(:items) { [{ string: 'foo', number: 30, boolean: false }] }
    let(:expected_lines) do
      ["string,number,boolean\nfoo,30,false\n\n"]
    end

    it_behaves_like 'correct_output'

    context 'with null as values' do
      let(:items) { [{ empty: nil }] }
      let(:expected_lines) { ["empty\n\n\n"] }

      it_behaves_like 'correct_output'
    end

    context 'with array as values' do
      let(:items) { [{ array: [1, 'foo'] }] }
      let(:expected_lines) do
        ["array\n\"[1,\"\"foo\"\"]\"\n\n"]
      end

      it_behaves_like 'correct_output'
    end

    context 'with other objects as values' do
      let(:items) { [{ hash: { foo: 'bar', num: 1 } }] }
      let(:expected_lines) do
        ["hash\n\"{\"\"foo\"\":\"\"bar\"\",\"\"num\"\":1}\"\n\n"]
      end

      it_behaves_like 'correct_output'
    end
  end

  context 'with multiple items' do
    let(:items) do
      [
        { string: 'foo' },
        { number: 30 },
        { boolean: false }
      ]
    end
    let(:expected_lines) do
      %W[string\nfoo\n\n number\n30\n\n boolean\nfalse\n\n]
    end

    it_behaves_like 'correct_output'
  end
end
