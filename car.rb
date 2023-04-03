require "socket"

TCPServer.new('localhost', 2000)

if ARGV.length >= 2
  host = ARGV.shift
else
  host = "localhost"
end

print("Trying ", host, " ...")

s = TCPSocket.new("localhost", 3333)
print(" done\n")
print("addr: ", s.addr.join(":"), "\n")
print("peer: ", s.peeraddr.join(":"), "\n")

line = "a\n"
# must end with \n
p line


s.write(line)
print(s.readline)
s.close