$:.unshift(File.join(File.expand_path(File.dirname(__FILE__))))

require 'packetfu'
require 'unimidi'
require 'log_parser/log'

cap = PacketFu::Capture.new(:iface => "en0", :start => true, :filter => "ip") # Line 1, set up the capture object.
output = UniMIDI::Output.use(:first)

while true
	cap.stream.each do |p|
		packet = PacketFu::Packet.parse(p) # Line 3, loop the capture forever, parsing packets.
		if packet.is_tcp?
			
			note = packet.tcp_dst / 517
			

			puts "#{Time.now}: %s:%s -> %s:%s [%s]" % 
			[packet.ip_saddr,packet.tcp_src, packet.ip_daddr, packet.tcp_dst, note]
			output.puts(0x90, note, 127) # note on message
			sleep 0.1  # wait
			output.puts(0x80, note , 127) # note off message
		end
	end
end