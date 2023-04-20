class ChoicesController
  def index
    @choices = Choice.all
    display_choices
  end

  def create(params)
    # print "Enter choice type: "
    # type = gets.chomp
    # print "Enter choice content: "
    # content = gets.chomp

    choice = Choice.new(params)
    choice.save
  end

  def edit
    print "Enter the ID of the choice to edit: "
    id = gets.chomp.to_i

    choice = Choice.find(id)
    if choice
      print "Enter new choice type (#{choice.type}): "
      new_type = gets.chomp
      print "Enter new choice content (#{choice.content}): "
      new_content = gets.chomp

      choice.type = new_type unless new_type.empty?
      choice.content = new_content unless new_content.empty?
      choice.save

      puts "Choice updated: #{choice}"
    else
      puts "Choice not found with ID #{id}"
    end
  end

  def delete
    print "Enter the ID of the choice to delete: "
    id = gets.chomp.to_i

    choice = Choice.find(id)
    if choice
      choice.destroy
      puts "Choice deleted: #{choice}"
    else
      puts "Choice not found with ID #{id}"
    end
  end

  private

  def display_choices
    @choices.each do |choice|
      puts "#{choice.id}, #{choice.type}, #{choice.content}"
    end
  end
end
