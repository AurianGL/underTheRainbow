require_relative 'base_service'
require 'io/console'
require 'securerandom'

class Matrice < BaseService
    def initialize(ascii_art)
      @ascii_art = ascii_art
    end

    def call
        # Call the method
        better
    end

    def bad
        num_rows = 30
        num_cols = 80
        
        # Define the characters to use in the animation
        characters = ['0', '1']
        
        # Clear the terminal screen
        system 'clear'
        
        # Loop indefinitely
        loop do
          # Generate a new frame of the animation
          frame = (0..num_rows-1).map do |row|
            (0..num_cols-1).map do |col|
              characters[rand(0..1)]
            end.join('')
          end.join("\n")
        
          # Move the cursor to the top-left corner of the terminal
          print "\e[H"
        
          # Print the current frame of the animation
          puts frame
        
          # Sleep for a short amount of time to control the speed of the animation
          sleep 0.1
        end 
    end

    def better
      # Define the size of the animation frame
      num_rows = @ascii_art.count("\n")
      num_cols = @ascii_art.split("\n").map(&:length).max

      # Define the characters to use in the animation
      characters = ['0', '1', '&', '%', '$', '#']

      # Clear the terminal screen
      system 'clear'

      # Print the initial ASCII art
      puts @ascii_art
      @ascii_art.tr('\n', '')
      # Loop indefinitely
      count =  0
      # previous frame is of the same size as the current frame
      previous_frame = " " * @ascii_art.length
      loop do
        # Generate a new frame of the animation by randomly changing characters
        count += 1
        frame = ''
        (0..num_rows-1).each do |row|
          (0..num_cols-1).each do |col|
            if row > count
              frame += ' '
            elsif @ascii_art[row * (num_cols + 1) + col] && @ascii_art[row * (num_cols + 1) + col] != ' '
              # compare with previous frame
              if row == 1
                if previous_frame[row * (num_cols + 1) + col] == 'j'
                  if rand(0) == 0
                    frame += @ascii_art[row * (num_cols + 1) + col]
                  else
                    frame += ' '
                  end
                else 
                  if rand(10) == 0 && !frame.nil?
                    frame += characters[rand(0..5)]
                  else
                    frame += @ascii_art[row * (num_cols + 1) + col] 
                  end
                end
              elsif previous_frame[row * (num_cols + 1) + col] != ' '
                if rand(10) == 0 && !frame.nil?
                  frame += characters[rand(0..5)]
                else
                  frame += @ascii_art[row * (num_cols + 1) + col] 
                end
              end
            else
              frame += ' '
            end
          end
          frame += "\n"
        end
        previous_frame = frame

        # Move the cursor to the top-left corner of the terminal
        print "\e[H"

        # Print the current frame of the animation
        puts frame

        # Sleep for a short amount of time to control the speed of the animation
        sleep 0.1
        break if count>num_rows * 1.2
      end
    end
end