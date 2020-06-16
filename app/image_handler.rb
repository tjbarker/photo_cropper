# frozen_string_literal: true

require 'rmagick'

# class for handling the integration with Rmagick
# functionality is based around image manipulation
class Image
  class << self
    include Magick

    def open(path)
      new(ImageList.new(path))
    end
  end

  def initialize(image)
    self.image = image
  end

  def resize(x, y = x)
    self.class.new(image.resize(x, y))
  end

  def crop(x, y, width, height = width)
    self.class.new(image.crop(x, y, width, height))
  end

  def write(path)
    image.write(path)
  end

  def crop_and_save(path, x, y, width, height = width)
    name = path + '.' + image.format
    crop(x, y, width, height).write(name)
  end

  def width
    image.columns
  end

  private

  attr_accessor :image
end
