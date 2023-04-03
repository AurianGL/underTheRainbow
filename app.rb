require "io/console"
require "./services/select.rb"
require "./display.rb"

Dir.glob(File.join(File.dirname(__FILE__), '**', 'init.rb')).each do |file|
  puts file
  require file
end

class App
  def initialize
    @selected_item_index = 0
    @menu_items = [
      "1. Hello world",
      "2. go fuck yourself"
    ]
    @actions = [:merme, :radar]
  end

  def launch
    puts "\nWelcome to the Magical World of OZ"
    puts "do you want to dive in the rabbit hole ?"
    answer = gets.chomp
    answer == "yes" ? selection = MenuSelect.call(@menu_items).selection : exit
    send(@actions[selection])
    exit
  end

  def merme
    File.open("ascii.txt", "r") do |f|
      # Read the file content and trim each line
      # trimmed_lines = f.readlines.map { |line| line.strip.slice(40..-40) }
      trimmed_lines = f.readlines.map do |line| 
        char_to_trim = (line.length - 100) / 2
        line.slice(/^.{#{char_to_trim}}(.{0,#{line.length-(char_to_trim * 2)}}).{#{char_to_trim}}$/, 1) 
      end

      # Print the trimmed lines to the console
      puts trimmed_lines
    end
  end

  def radar
    "DISPLAY SOMETHING GOOD AND FUN"
  end
end

App.new.launch