#!/usr/bin/env ruby
require 'rubygems'
#require File.dirname(__FILE__)+'/../lib/sfc_ikiteru'
require 'sfc_ikiteru'

per, details = SfcIkiteru.ikiteru
p per
p details
