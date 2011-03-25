# -*- coding: utf-8 -*-
require 'rubygems'
require 'socket'
require 'timeout'
require 'eventmachine'

module SfcIkiteru
  VERSION = '0.0.7'
  def SfcIkiteru.servers
    [
     {:host => 'web.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'ccz01.sfc.keio.ac.jp', :service => 'ssh'},
     {:host => 'ccz02.sfc.keio.ac.jp', :service => 'ssh'},
     {:host => 'mail.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'www.mag.keio.ac.jp', :service => 'echo'},
     {:host => 'cpu0.mag.keio.ac.jp', :service => 'echo'},
     {:host => 'gw2.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'keio.gw.sinet.ad.jp', :service => 'echo'},
     {:host => 'shonan.sfc.wide.ad.jp', :service => 'echo'},
     {:host => 'masui.sfc.keio.ac.jp', :service => 'http'}
    ]
  end

  def SfcIkiteru.ikiteru(timeout=3)
    results = Array.new

    EM::run do
      EM::defer do
        loop do
          EM::stop if results.size >= servers.size
          sleep 0.1
        end
      end
      servers.each{|s|
        EM::defer do
          res = ping(s[:host], timeout, s[:service])
          results << {:host => s[:host], :ping => res}
        end
      }
    end
    count = 0
    results.each{|i|
      count+=1 if i[:ping] == true
    }
    per = count.to_f / results.size
    return per, results
  end

  def SfcIkiteru.ping(host, timeout=5, service="echo")
    begin
      timeout(timeout) do
        TCPSocket.new(host, service).close
      end
    rescue Errno::ECONNREFUSED
      return true
    rescue Timeout::Error, StandardError
      return false
    end
    return true
  end
end
