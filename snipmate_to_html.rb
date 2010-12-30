#! /usr/bin/ruby
require 'find'

class Snippet
  attr_accessor :module
  attr_accessor :snippet
  attr_accessor :file
end
directory = ARGV[0]
snippets = {}
Find.find(directory) do |file| 
  if file =~ /snippet$/
    snippet = Snippet.new
    snippet.file = file
    splitted = file.gsub(directory, "").split /\//
    snippet.module = splitted[0..-2]
    snippet.snippet = splitted[-1]
    snippets[snippet.module] ||= []
    snippets[snippet.module] << snippet
  end
end

snippets.each do |key, value|
  print "<h1>"
  key.each do |subkey|
    print "#{subkey}:"
  end
  puts "</h1>"
  puts "<table>"
  value.each do |snippet|
    puts "<tr>"
    print "<td>#{snippet.snippet}</td><td>"
    File.open(snippet.file).each_line do |line|
      print "#{line}<br />"
    end
    puts "</td></tr>"
  end
  puts "</table>"
end
