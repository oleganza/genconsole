#!/usr/bin/env ruby
require 'fileutils'

puts "This scripts generates two files to power your 
library or an app with an IRb console.

"

def query(title, default = nil)
  print(default ? "#{title} [#{default}]: " : "#{title}: ")
  path = gets.strip
  path = default if path.empty? 
  yield(path) if block_given?
  path
end

binpath = query("Path to executable", "bin/console")
modpath = query("Path to module",     "console.rb") do |m|
  m << ".rb" unless m[".rb"]
end

modname = query("Console module name", "Console")

exetplpath = File.expand_path(File.join(File.dirname(__FILE__), "executable_template.rb"))
modtplpath = File.expand_path(File.join(File.dirname(__FILE__), "module_template.rb"))

exe = File.read(exetplpath)
mod = File.read(modtplpath)

exe.gsub!(/Console/, modname)
exe.gsub!(%r{/\.\./console}, "/" + "../"*(binpath.split("/").size-1) + modpath)

mod.gsub!(/Console/, modname)

puts ""
puts "Your configuration:"
puts "  Path to executable: #{binpath}"
puts "  Path to module:     #{modpath}"
puts "  Module name:        #{modname}"

puts ""
confirm = query("Create files?", "y/n/show").downcase

case confirm
when /^y/:
  
  FileUtils.mkdir_p(File.dirname(binpath))
  FileUtils.mkdir_p(File.dirname(modpath))
  File.open(binpath, "w"){|f| f.write(exe) }
  File.open(modpath, "w"){|f| f.write(mod) }
  system("chmod +x #{binpath}")
  
  puts "Files created."
when /^s/:
  puts ""
  puts ""
  puts binpath
  puts "-"*50
  puts exe
  puts "-"*50
  puts ""
  puts ""
  puts modpath
  puts "-"*50
  puts mod
  puts "-"*50
  puts ""
else
  puts "Bye."  
end
