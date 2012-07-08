$:.unshift(File.join(File.expand_path(File.dirname(__FILE__))))

#require 'packetfu'
require 'unimidi'
require 'log_parser/log'

output = UniMIDI::Output.use(:first)

BroIds::Conn::Log.tail_file(File.open("./data/log")) do |line| 
	puts "#{Time.at(line[:ts].to_i)} - #{line[:service]} - port: #{line[:id_resp_p]}"
	port = line[:id_resp_p].to_i
	Thread.new do
		note = port / 517
		output.puts(0x90, note, 127) # note on message
		sleep 1 #sleep()  # wait
		output.puts(0x80, port/127 , 127) # note off message
	end
end