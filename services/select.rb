require_relative 'base_service'

class MenuSelect < BaseService
  def initialize(menu_items)
    @action
    @selected_item_index = 0
    @menu_items = menu_items
  end

  class Result
    attr_reader :selection

    def initialize(selection)
      @selection = selection
    end
  end

  def call
    menu
  end
  
  private 
  
  def menu
    loop do
      system 'clear' # clear the terminal screen
      puts "\nChoose an action"
      @menu_items.each.with_index do |item, index|
        if index == @selected_item_index
          puts "\e[31m#{item}\e[0m"
        else
          puts "#{item}"
        end
      end

      @action = STDIN.getch
      case @action
      when "\r" # Enter key
        system 'clear'
        puts "You chose #{@menu_items[@selected_item_index]}"
        return Result.new(selection = @selected_item_index)
      when "\e" # Escape character
        if STDIN.getch == '[' # Control sequence
          case STDIN.getch # Final character
          when 'A' # Up arrow key
            @selected_item_index = (@selected_item_index - 1) % @menu_items.length
          when 'B' # Down arrow key
            @selected_item_index = (@selected_item_index + 1) % @menu_items.length
          end
        end
      end
    end
  end
end
