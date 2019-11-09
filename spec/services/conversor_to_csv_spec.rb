# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ConversorToCSV do
  subject(:csv) { described_class.new(items).call }

  shared_examples 'correct_output' do
    it 'returns correct CSV' do
      expect(csv).to eq expected_csv
    end
  end

  context 'with empty items array' do
    let(:items) { [] }
    let(:expected_csv) { '' }

    it_behaves_like 'correct_output'
  end

  context 'with single items' do
    let(:items) { [{ string: 'foo', number: 30, boolean: false }] }
    let(:expected_csv) do
      "string,number,boolean\nfoo,30,false\n\n"
    end

    it_behaves_like 'correct_output'

    context 'with null as values' do
      let(:items) { [{ empty: nil }] }
      let(:expected_csv) { "empty\n\n\n" }

      it_behaves_like 'correct_output'
    end

    context 'with array as values' do
      let(:items) { [{ array: [1, 'foo'] }] }
      let(:expected_csv) do
        "array\n\"[1,\"\"foo\"\"]\"\n\n"
      end

      it_behaves_like 'correct_output'
    end

    context 'with other objects as values' do
      let(:items) { [{ hash: { foo: 'bar', num: 1 } }] }
      let(:expected_csv) do
        "hash\n\"{\"\"foo\"\":\"\"bar\"\",\"\"num\"\":1}\"\n\n"
      end

      it_behaves_like 'correct_output'
    end
  end
end
