require 'csv'

# Prompt the user for a to-do item and deadline
print "Enter a to-do item: "
todo_item = gets.chomp
print "Enter a deadline (YYYY-MM-DD): "
deadline = gets.chomp

# Create a CSV file and write the to-do item and deadline to it
CSV.open("todo.csv", "a") do |csv|
  csv << [todo_item, deadline, "incomplete"]
end

# Print a message to confirm that the item was added to the to-do list
puts "#{todo_item} (deadline: #{deadline}) has been added to your to-do list!"

# Display incomplete items
puts "\nIncomplete items:"
CSV.foreach("todo.csv") do |row|
  if row[2] == "incomplete"
    puts "#{row[0]} (deadline: #{row[1]})"
  end
end

# Display outdated items
puts "\nOutdated items:"
CSV.foreach("todo.csv") do |row|
  if row[1] < Date.today.to_s && row[2] == "incomplete"
    puts "#{row[0]} (deadline: #{row[1]})"
  end
end

# Prompt the user to mark an item as done
print "\nEnter the name of a completed item: "
completed_item = gets.chomp

# Update the CSV file to mark the item as done
CSV.open("todo.csv", "w") do |csv|
  CSV.foreach("todo.csv") do |row|
    if row[0] == completed_item
      csv << [row[0], row[1], "done"]
    else
      csv << row
    end
  end
end

# Print a message to confirm that the item was marked as done
puts "#{completed_item} has been marked as done."

# Display incomplete items again to confirm that the completed item was updated
puts "\nIncomplete items:"
CSV.foreach("todo.csv") do |row|
  if row[2] == "incomplete"
    puts "#{row[0]} (deadline: #{row[1]})"
  end
end