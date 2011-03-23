require 'ping'

module SfcIkiteru
  VERSION = '0.0.2'
  def SfcIkiteru.servers
    [
     {:host => 'web.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'ccz01.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'ccz02.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'mail.sfc.keio.ac.jp', :service => 'echo'},
     {:host => 'masui.sfc.keio.ac.jp', :service => 'http'}
    ]
  end

  def SfcIkiteru.ikiteru(timeout=3)
    results = Array.new
    servers.each{|s|
      results << {:host => s[:host], :ping => Ping.pingecho(s[:host], timeout, s[:service])}
    }
    count = 0
    results.each{|i|
      count+=1 if i[:ping] == true
    }
    per = count.to_f / results.size
    return per, results
  end
end
