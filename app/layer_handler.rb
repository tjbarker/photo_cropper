# frozen_string_literal: true

require_relative 'tiler.rb'
require_relative 'layer_image_wrapper.rb'
require 'fileutils'

class LayerHandler
  class << self
    # build a list of LayerHandlers for an image and directory up to a depth_max
    def build_multi(image:, directory:, depth_max:)
      raise ArgumentError unless depth_max.is_a?(Integer) && depth_max.positive?

      (0..depth_max - 1).map { |depth| new(image, directory, depth) }
    end
  end

  def initialize(image, directory, depth)
    self.directory = directory
    self.depth = depth
    self.width = image.width
    self.image_wrapper = LayerImageWrapper.new(image, depth, directory)
  end

  def call
    return if crop_distance < 1

    puts "depth: #{depth + 1}"
    make_directory

    Tiler.call(width: width, step: crop_distance) do |x, y|
      image_wrapper.crop_and_save(x, y, crop_distance)
    end
  end

  private

  attr_accessor :directory, :image_wrapper, :depth, :width

  def crop_distance
    width / 2**depth
  end

  def make_directory
    FileUtils.mkdir_p([directory, depth.to_s].join('/'))
  end
end
