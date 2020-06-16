# frozen_string_literal: true

class LayerImageWrapper
  def initialize(image, depth, directory)
    self.image = image
    self.depth = depth
    self.directory = directory
  end

  def crop_and_save(x, y, crop_distance)
    image.crop_and_save(path_for(x, y), x, y, crop_distance)
  end

  private

  def path_for(x, y)
    [directory, depth, "#{x}_#{y}"].join('/')
  end

  attr_accessor :image, :depth, :directory
end

