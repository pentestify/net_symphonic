require 'packetfu' 
require 'MIDIator'

cap = PacketFu::Capture.new(:iface => ARGV[0], :start => true, :filter => "ip")

loop {
	cap.stream.each {
		|pkt| packet = PacketFu::Packet.parse(pkt) 
		p "#{Time.now}: %s slammed %s" % [packet.ip_saddr, packet.ip_daddr] if packet.payload =~ /^\x04\x01{50}/ 
	}	
}
