require 'thor'
require 'pry'

class MyCLI < Thor
  desc "hello NAME", "say hello to NAME"
  def hello(name, from=nil)
    puts "from: #{from}" if from
    puts "Hello #{name}"
  end

  desc "hello NAME", "say hello to NAME"
  def repl
    blah = ['one', 'two', 'three', 'four']
    blah = blah.map.with_index{ |a, i| [i+1, *a]}

    loop do
      print_table(blah)
      meow = ask('what you want?:')
      puts meow
    end
  end
end

class Proctor
end


MyCLI.start(ARGV)
