# frozen_string_literal: true

require 'rmagick'
require_relative '../../app/image_handler'

include Magick

describe Image do
  shared_examples 'calls write' do
    it 'calls write' do
      expect(save_file).to receive(:write).with(path)
      subject
    end
  end

  shared_examples 'calls crop' do
    it 'returns a new Image class with cropped image as image' do
      allow(file).to receive(:crop).with(x, y, width, height) { cropped_image }
      expect(subject.send(:image)).to eq cropped_image
    end
  end

  describe 'open' do
    let(:path) { double(:path) }
    let(:image) { double(:image) }

    subject { Image.open path }

    it 'instanciates with result from ImageList' do
      allow(ImageList).to receive(:new).with(path) { image }
      expect(subject.send(:image)).to eq image
    end
  end

  describe 'resize' do
    let(:file) { double(:image) }
    let(:image) { Image.new(file) }
    let(:resized_image) { double(:resized_image) }
    let(:x) { double(:x) }

    shared_examples 'calls resize' do
      it 'returns a new Image class with resized image as image' do
        allow(file).to receive(:resize).with(x, y) { resized_image }
        expect(subject.send(:image)).to eq resized_image
      end
    end

    context 'when only x used' do
      subject { image.resize(x) }
      let(:y) { x }

      include_examples 'calls resize'
    end

    context 'when x and y used' do
      subject { image.resize(x, y) }
      let(:y) { double(:y) }

      include_examples 'calls resize'
    end
  end

  describe 'crop' do
    let(:file) { double(:image) }
    let(:image) { Image.new(file) }
    let(:cropped_image) { double(:cropped_image) }
    let(:x) { double(:x) }
    let(:y) { double(:y) }
    let(:width) { double(:width) }

    context 'when only width used' do
      subject { image.crop(x, y, width) }
      let(:height) { width }

      include_examples 'calls crop'
    end

    context 'when x and y used' do
      subject { image.crop(x, y, width, height) }
      let(:height) { double(:height) }

      include_examples 'calls crop'
    end
  end

  describe 'write' do
    let(:save_file) { double(:image) }
    let(:path) { double(:path) }
    let(:image) { Image.new(save_file) }

    subject { image.write(path) }

    include_examples 'calls write'
  end

  describe 'crop_and_save' do
    let(:file) { double(:image, format: format) }
    let(:image) { Image.new(file) }
    let(:cropped_image) { double(:cropped_image) }
    let(:x) { double(:x) }
    let(:y) { double(:y) }
    let(:width) { double(:width) }
    let(:height) { width }

    let(:save_file) { double(:image) }
    let(:path) { 'path' }
    let(:format) { 'format' }

    subject { image.crop_and_save(path, x, y, width) }

    it 'calls crop and write' do
      allow(file).to receive(:crop).with(x, y, width, height) { save_file }
      expect(save_file).to receive(:write).with(path + '.' + format)
      subject
    end
  end

  describe 'width' do
    let(:file) { double(:image) }
    let(:columns) { double(:columns) }
    let(:image) { Image.new(file) }

    subject { image.width }

    it 'checks file for columns' do
      allow(file).to receive(:columns) { columns }
      expect(subject).to eq columns
    end
  end
end
