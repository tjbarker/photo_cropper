require_relative '../../app/run'

describe Run do
  describe 'call' do
    let(:image) { double(:image) }
    let(:resized_image) { double(:resized_image) }
    let(:path) { double(:path) }
    let(:depth) { double(:depth, to_i: int_depth) }
    let(:int_depth) { double(:int_depth) }
    let(:layers) { [layer, layer, layer, layer] }
    let(:layer) { double(:layer) }

    subject { described_class.call(path: path, depth: depth, directory: directory) }

    before do
      expect(image).to receive(:resize).with(Run::DEFAULT_SIZE) { resized_image }
    end

    shared_examples 'runs functionality' do
      it 'opens image, builds depth and calls layers to run' do
        allow(Image).to receive(:open).with(path) { image }
        allow(LayerHandler).to receive(:build_multi).with(
          image: resized_image,
          directory: output_path,
          depth_max: int_depth
        ) { layers }

        expect(layer).to receive(:call).exactly(layers.length).times
        expect(STDOUT).to receive(:puts).with('done')
        subject
      end
    end

    context 'when directory used' do
      let(:directory) { double(:directory) }
      let(:output_path) { directory }

      include_examples 'runs functionality'
    end

    context 'when no directory passed in' do
      let(:time) { 'time-now' }
      let(:directory) { nil }
      let(:output_path) { "#{Run::OUTPUT_PATH}/#{time}" }

      before do
        allow(Time).to receive_message_chain(:now, :iso8601) { time }
      end

      include_examples 'runs functionality'
    end
  end
end
