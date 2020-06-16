# frozen_string_literal: true

require_relative 'app/image_handler'
require_relative 'app/layer_handler'

class Tile
  DEFAULT_SIZE = 256
  OUTPUT_PATH = 'outputs'

  class << self
    def call(path:, depth:, directory: nil)
      image = Image.open path
      directory ||= [OUTPUT_PATH, Time.now.iso8601].join('/')
      new(image.resize(DEFAULT_SIZE), depth.to_i, directory).call
    end
  end

  def initialize(image, depth, directory)
    self.depth_list = LayerHandler.build_multi(
      image: image,
      directory: directory,
      depth_max: depth
    )
  end

  def call
    depth_list.each(&:call)
    puts 'done'
  end

  private

  attr_accessor :depth_list
end

inputs = ARGV.each_slice(2).to_h

Tile.call(
  path: inputs.fetch('--image-path', 'images/cat.png'),
  depth: inputs.fetch('--depth', 3),
  directory: inputs.fetch('--directory', nil)
)
