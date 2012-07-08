require 'rubygems'
require 'packetfu'
require 'midiator'

cap = PacketFu::Capture.new(:iface => "eth0", :start => true, :filter => "ip") # Line 1, set up the capture object.
midi = MIDIator::Interface.new
midi.autodetect_driver

alerts = ["80"] # Line 2, define your attack patterns.

loop {
	cap.stream.each {|pkt|
		packet = PacketFu::Packet.parse(pkt) # Line 3, loop the capture forever, parsing packets.
		if packet.is_tcp?
			alerts.each { |alert|
				if packet.tcp_dst.to_s == alert
				 	puts "#{Time.now}: %s:%s -> %s:%s [%s]" % 
						[packet.ip_saddr,packet.tcp_src, packet.ip_daddr, packet.tcp_dst, alert]
				 	midi.play( packet.tcp_src%84, 0.5 )
				end
			}
		end
	}
}
