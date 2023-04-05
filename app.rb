require "io/console"
require "./services/select.rb"
require "./display.rb"
require "./tree.rb"
require 'csv'


Dir.glob(File.join(File.dirname(__FILE__), '**', 'init.rb')).each do |file|
  puts file
  require file
end

class App
  def initialize
    @selected_item_index = 0
    @menu_items = [
      "1. Go to Berlin",
      "2. NØ"
    ]
    @actions = [:merme, :radar]
    @choices = []
  end

  def launch
    puts "\nWelcome to the Magical World of OZ"
    puts "do you want to dive in the rabbit hole ?"
    answer = gets.chomp
    if answer == "yes"
      navigate_decision_tree(TREE)
    else
      exit
    end
  end

  private

  def navigate_decision_tree(tree)
    @current_node = tree
    loop do
      if @current_node.is_a?(Symbol)
        send(@current_node)
        break
      else
        @selection = MenuSelect.call(@current_node.keys.flatten).selection
        @previous_node = @current_node
        next_node_key = @current_node.keys[@selection]
        @current_node = @current_node[next_node_key]
      end
    end
  end

  def store_date
  end

  def display_choices
    puts @choices.flatten
  end

  def back(field = nil)
    @choices << "#{field} : #{@previous_node.keys[@selection]}" if field
    navigate_decision_tree(TREE["1. Go to Berlin"])
  end

  def date
    back("date")
  end

  def act
    back("activité")
  end

  def place
    back("lieu")
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

  def suggestions
    puts "type in your suggestions"
    suggestion = gets.chomp
    @choices << "suggestions : #{suggestion}"
    back 
  end

  def stop    
    File.open("choices.txt", "w") do |file|
      @choices.each do |choice|
        file.puts choice
      end
    end
    puts "Thanks for your choices they have been saved in choices.csv"
    exit
  end

  def radar
    "DISPLAY SOMETHING GOOD AND FUN"
  end
end

App.new.launch