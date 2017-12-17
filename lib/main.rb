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
    proctor = Proctor.new
    loop do
      say(proctor.question)
      print_table(proctor.options)
      answer = ask("what do you think? >>").to_i

      if answer == 2
        say("you're a vim winner")
      else
        say("unfortunately that is the incorrect answer, please please please try again")
      end
    end
  end
end

class Proctor
  def question
    "What does h do?"
  end

  def options
    option_set = ['goes around', 'moves cursor left', 'executes sys call', 'moves cursor down']
    prepare_options(option_set)
  end

  def prepare_options(options)
    options.map.with_index{ |a, i| [i+1, *a]}
  end
end


MyCLI.start(ARGV)
