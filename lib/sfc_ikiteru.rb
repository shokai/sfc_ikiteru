require 'ping'

module SfcIkiteru
  VERSION = '0.0.1'
  def SfcIkiteru.servers
    [
     {:host => 'masui.sfc.keio.ac.jp', :service => 'http'},
     {:host => 'web.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'ccz01.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'ccz02.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'mail.sfc.keio.ac.jp', :service => 'echo'}
    ]
  end

  def SfcIkiteru.ikiteru(timeout=3)
    results = Array.new
    servers.each{|s|
      results << {:host => s[:host], :ping => Ping.pingecho(s[:host], timeout, s[:service])}
    }
    results
  end
end
