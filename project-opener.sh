#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'finder'
require 'yaml'

workspace   = ENV["PO_WORKSPACE"] || Dir.pwd
depth       = ENV["PO_DEPTH"] ? ENV["PO_DEPTH"].to_i : 1
path        = "."
finder      = Finder.new(workspace, depth, ARGV.first)

if finder.candidates.empty?
  $stderr.print "Could not locate a project by that description\n"
elsif !finder.only_one_candidate?
  $stderr.print "Multiple candidates found - please be more specific\n"
  $stderr.print finder.candidates.to_yaml
else
  path = finder.candidates.first
end

puts path
