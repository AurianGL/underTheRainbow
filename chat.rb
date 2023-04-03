require 'socket'

# Get the user's name
print "Enter your name: "
name = gets.chomp

# Get the IP address and port number of the remote peer
print "Enter the remote IP address: "
remote_ip = gets.chomp
print "Enter the remote port number: "
remote_port = gets.chomp.to_i

# Create a TCP socket and connect to the remote peer
sock = TCPSocket.new(remote_ip, remote_port)

# Send a greeting message to the remote peer
sock.puts "Hello, #{name}!"

# Start the chat loop
loop do
  # Read a message from the remote peer
  msg = sock.gets.chomp
  puts "#{name}: #{msg}"

  # Get a message from the user and send it to the remote peer
  print "#{name}: "
  msg = gets.chomp
  sock.puts msg
end