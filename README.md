# Photo Tiler

Photo tiler is a small application for cropping a larger photo into smaller tiles that can be independantly loaded/viewed.

## Installation

Photo tiler requires ruby to run. It was developed with ruby 2.6.5 however other versions will probably work.

[Bundler](https://bundler.io/) can be used to handle to library requirements.\
From the home directory run the following to install dependencies.
```bash
bundle install
```

[ImageMagick](https://imagemagick.org/index.php) is used under the covers to do the image manipulation.\
It may be required to be installed outside the standard bundler flow. I used [brew](https://brew.sh/) to install ImageMagick using the following.
```bash
brew install imagemagick
```

## Run

### Command line

#### Basic
To run using the default image.
```bash
ruby tile.rb
```

#### Custom image
A custom image can be tiled using the `--image-path` argument.\
N.B the input file will be auto resized to 256x256 pixel for tiling, the original image will not be updated.
```bash
ruby tile.rb --image-path path/to/custom/image.png
```

#### Custom output directory
A custom output path can be used using the `--directory` argument.\
N.B conflicting file will be overwritten.
```bash
ruby tile.rb --directory path/to/output/directory
```

#### Custom depth
The depth to which the tiling occurs can be customised using the `--depth` argument.\
N.B for 256x256 images, the greatest depth is 9 layers.
```bash
ruby tile.rb --depth 3
```

## Contributing

Pull requests are welcome. For major changes, please open an issue to discuss changes with the community first.

## License
[MIT](https://choosealicense.com/licenses/mit/)
