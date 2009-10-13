#!/usr/bin/env ruby

require 'finder'
require 'yaml'

workspace   = ENV["PO_WORKSPACE"] || Dir.pwd
depth       = ENV["PO_DEPTH"].to_i rescue 1
path        = "."
finder      = Finder.new(workspace, depth, ARGV.first)

if finder.candidates.empty?
  $stderr.print "Could not locate a project by that description"
elsif !finder.only_one_candidate?
  $stderr.print "Multiple candidates found - please be more specific\n"
  $stderr.print finder.candidates.to_yaml
else
  path = finder.candidates.first
end

puts path
