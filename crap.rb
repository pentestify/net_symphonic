require 'rubygems'
require 'midiator'

class Midinet

	def initialize
		@midi = MIDIator::Interface.new
		@midi.autodetect_driver
		@midi.play( 84, 0.5 )
	end

	def play
		@midi.play(84, 1)
	end

end
