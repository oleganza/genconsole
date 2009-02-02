# This file contains helpers and shortcuts for bin/console
#
# TODO: Load your primary file here:
# require File.expand_path(File.dirname(__FILE__) + "/path/to/the/zoo")

require 'irb'
require 'pp'
module Console extend self
  
  def start
    puts version
    Object.send(:include,self)
    IRB.start
  end
  
  def version
    "Zoo 6.2.1: Animals all over the world (help! for more info)"
  end
  
  def help!
    puts "  hello             Prints 'Hello, world!'"
    puts "  hello(subject)    Prints 'Hello, \#{subject}!'"
    puts "  exit, quit, q     Exit IRb session"
  end
  
  #
  # Custom methods for IRb go here
  #
  def hello(subject = "world")
    "Hello, #{subject}!"
  end
  
  def q
    quit
  end
end
