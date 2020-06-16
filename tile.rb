# frozen_string_literal: true

require_relative 'app/run'

inputs = (ARGV || []).each_slice(2).to_h

Run.call(
  path: inputs.fetch('--image-path', 'images/cat.png'),
  depth: inputs.fetch('--depth', 3),
  directory: inputs.fetch('--directory', nil)
)
