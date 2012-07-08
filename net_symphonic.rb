$:.unshift(File.join(File.expand_path(File.dirname(__FILE__))))

#require 'packetfu'
require 'unimidi'
require 'log_parser/log'

#cap = PacketFu::Capture.new(:iface => "en1", :start => true, :filter => "ip") # Line 1, set up the capture object.
output = UniMIDI::Output.use(:first)

BroIds::Conn::Log.tail_file(File.open("./data/log")) do |line| 
	puts "#{Time.at(line[:ts].to_i)} - #{line[:service]} - port: #{line[:id_resp_p]}"
	port = line[:id_resp_p].to_i
	Thread.new do
		note = port / 517
		output.puts(0x90, note, 127) # note on message
		puts line.inspect
		sleep 1 #sleep()  # wait
		output.puts(0x80, port/127 , 127) # note off message
	end
end

=begin
while true
	cap.stream.each do |p|
		packet = PacketFu::Packet.parse(p) # Line 3, loop the capture forever, parsing packets.
		if packet.is_tcp?
			alerts.each do |alert|
				play = 

				if packet.tcp_dst.to_s == alert
				 	
				 	puts "#{Time.now}: %s:%s -> %s:%s [%s]" % 
				 	[packet.ip_saddr,packet.tcp_src, packet.ip_daddr, packet.tcp_dst, "ohnoes"]
			 		

				end
			end
		end
	end
end
=end