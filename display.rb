require 'chunky_png'
require 'colorize'

class Display
  def initialize(url)
      # Open the image file
    @image = ChunkyPNG::Image.from_file(url)
    # Set the block size
    @block_size = 4
  end

  def conversion
    # Loop through each row of the image
    (0...@image.height).step(@block_size).each do |y|

      # Loop through each column of the image
      (0...@image.width).step(@block_size).each do |x|

        # Get the color of the pixel at the current block
        color = @image[x, y]

        # Convert the color to an ANSI256 color code
        color_code = 16 + (36 * (color >> 16 & 0xFF) / 255) + (6 * (color >> 8 & 0xFF) / 255) + (color & 0xFF / 51)

        # Print the block in the terminal with the corresponding color
        print ' '.colorize(background: color_code)
      end

      # Print a new line after each row
      puts
    end
  end
end