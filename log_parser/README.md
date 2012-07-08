# bro_ids-conn-log

This library will parse the CONN log files created by BRO IDS (http://www.bro-ids.org/) and prepare the fields to be called by name in your scripts.

## Usage

	require 'bro_ids/conn/log'
	BroIds::Conn:Log.parse('YOUR CONN LOG LOCATION HERE')

## Example 1:

	require 'bro_ids/conn/log'

	conn_log = File.open("conn.log")
	BroIds::Conn::Log.parse(conn_log) do |parsed|
	  puts "At " + parsed[:timestamp] + " IP " +   parsed[:id_orig_h].to_s + " Requested " + parsed[:query] + " From " + parsed[:id_resp_h].to_s
	end


## Example 2:

	require 'bro_ids/conn/log'

	conn_log = File.open("conn.log")
	BroIds::Conn::Log.parse(conn_log) do |parsed|
	  puts parsed[:timestamp]
	  puts parsed[:uid]
	  puts parsed[:id_orig_h]
	  puts parsed[:id_orig_p]
	  puts parsed[:id_resp_h]
	  puts parsed[:id_resp_p]
	  puts parsed[:proto]
	  puts parsed[:trans_id]
	  puts parsed[:query]
	  puts parsed[:qclass]
	  puts parsed[:qclass_name]
	  puts parsed[:qtype]
	  puts parsed[:qtype_name]
	  puts parsed[:rcode]
	  puts parsed[:rcode_name]
	  puts parsed[:qr]
	  puts parsed[:aa]
	  puts parsed[:tc]
	  puts parsed[:rd]
	  puts parsed[:ra]
	  puts parsed[:z]
	  puts parsed[:answers]
	  puts parsed[:ttls]
	end
