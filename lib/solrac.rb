require 'socket'
require 'byebug'

class Solrac
  def initialize 
    @port = 3000
  end

  def listen(port, msg = "")
    @port = port

    start_server
  end

  def method_missing(verb, *args, &block)
    raise "Invalid method #{verb.upcase}" unless [:get, :post, :put, :delete, :patch].include?(verb)
  end

  private 

  attr_accessor :port

  def start_server
    server = TCPServer.new port 

    loop do
      client = server.accept
      request_line = client.readline

      http_verb, path, version = request_line.split

      headers = { 
        'Content-Type' => 'application/json', 
      }

      response = "HTTP/1.1 200\r\n"
      headers.each { |key, value| response += "#{key}: #{value}\r\n" }

      client.puts response

      client.close
    end
  end


  #TODO
  def handle_client(client)
  end
end
