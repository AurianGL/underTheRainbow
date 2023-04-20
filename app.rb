require "io/console"
require "./services/select.rb"
require "./display.rb"
require "./tree.rb"
require 'csv'
require "./services/matrice.rb"
require "./models/choices"
require "./controllers/choices_controller"
require "./routes"

Dir.glob(File.join(File.dirname(__FILE__), '**', 'init.rb')).each do |file|
  puts file
  require file
end

class App
  def initialize
    @selected_item_index = 0
    @choices_controller = ChoicesController.new
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
    # title = some ascii art writting BERLIN
    title = <<~ART
      *********************  UNDER THE  **********************
      ██████╗  █████╗ ██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗
      ██╔══██╗██╔══██╗██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║
      ██████╔╝███████║██║██╔██╗ ██║██████╔╝██║   ██║██║ █╗ ██║
      ██╔══██╗██╔══██║██║██║╚██╗██║██╔══██╗██║   ██║██║███╗██║
      ██║  ██║██║  ██║██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝
      ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ 
      ********************************************************
    ART

    @current_node = tree
    loop do
      if @current_node.is_a?(Symbol)
        send(@current_node)
        break
      else
        @selection = MenuSelect.call(@current_node.keys.flatten, title).selection
        @previous_node = @current_node
        next_node_key = @current_node.keys[@selection]
        @current_node = @current_node[next_node_key]
      end
    end
  end

  def display_choices
    puts @choices.flatten
  end

  def back(field = nil)
    Router.route("choices/create?type=#{field}&content=#{@previous_node.keys[@selection]}") if field
  # choices_controller.create({type: field, content: [@previous_node.keys[@selection]]}) if field
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

  def show_choices
    Router.route("choices/index")
    ok = gets.chomp
    unless ok.nil?
      back
    else
      exit
    end
  end

  def merme
    File.open("ascii-art.txt", "r") do |f|
      # Read the file content and trim each line
      # trimmed_lines = f.readlines.map { |line| line.strip.slice(40..-40) }
      trimmed_lines = f.readlines[10..50].map do |line| 
        char_to_trim = (line.length - 100) / 2
        line.slice(/^.{#{char_to_trim}}(.{0,#{line.length-(char_to_trim * 2)}}).{#{char_to_trim}}$/, 1) 
      end.take(40)
      # Print the trimmed lines to the console
      Matrice.call(trimmed_lines.join("\n"))
    end
  end

  def suggestions
    puts "type in your suggestions"
    suggestion = gets.chomp
    Router.route("choices/create?type=suggestions&content=#{suggestion}")
    back
  end

  def stop    
    merme
    puts "Thanks for your choices "
    exit
  end

  def radar
    "DISPLAY SOMETHING GOOD AND FUN"
  end
end

App.new.launch