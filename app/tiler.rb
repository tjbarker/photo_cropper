# frozen_string_literal: true

# class for returning funtion that iterates
# through steps in a grid
class Tiler
  class << self
    def call(width:, step:, height: width)
      new(width, height, step).call do |x, y|
        yield x, y
      end
    end
  end

  def initialize(width, height, step)
    self.width = width
    self.height = height
    self.step = step
  end

  def call
    (0..width - 1).step(step) do |x|
      (0..height - 1).step(step) do |y|
        yield x, y
      end
    end
  end

  private

  attr_accessor :width, :height, :step
end
