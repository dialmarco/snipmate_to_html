#! /usr/bin/ruby
require 'find'

class Snippet
  attr_accessor :module
  attr_accessor :snippet
  attr_accessor :file
end
directory = ARGV[0]
Find.find(directory) do |file| 
  if file =~ /snippet$/
    snippet = Snippet.new
    snippet.file = file
    snippet.module, snippet.snippet = file.gsub(directory, "").split /\//
    puts "#{snippet.module} : #{snippet.snippet} => #{snippet.file}"
  end
end
