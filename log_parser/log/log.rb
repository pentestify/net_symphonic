require 'file-tail'

module BroIds
  module Conn
    module Log
      
      def self.parse(filename, &block)
        parse_file(filename, &block)
      end

      private
        def self.parse_line(line)
          m = line.split(' ')
          if m
          { :ts            => m[0],
           :uid           => m[1],
           :id_orig_h     => m[2],
           :id_orig_p     => m[3],
           :id_resp_h     => m[4],
           :id_resp_p     => m[5],
           :proto         => m[6],
           :service       => m[7],
           :duration      => m[8],
           :orig_bytes    => m[9],
           :resp_bytes    => m[10],
           :conn_state    => m[11],
           :local_orig    => m[12],
           :missed_bytes  => m[13],
           :history       => m[14],
           :orig_pkts     => m[15],
           :orig_ip_bytes => m[16],
           :resp_pkts     => m[17],
           :resp_ip_bytes => m[18]
         }
        else
          {}
        end
      end

      def self.parse_file(filename)
        lines = [] 
        File.foreach(filename) do |line|
          unless line =~ /^\#/
            lines << parse_line(line)
          end
        end
      lines
      end

      def self.tail_file(filename, &block)
        File.open(filename) do |log|
          log.extend(File::Tail)
          log.interval = 10
          log.backward(10)
          log.tail do |line| 
              parsed = parse_line line
              yield parsed
            end
          end
      end

      def self.parse_file(filename, &block)
        File.foreach(filename) do |line|
          unless line =~ /^\#/
            parsed = parse_line(line)
            yield parsed
          end
        end
      end
    end
  end
end

