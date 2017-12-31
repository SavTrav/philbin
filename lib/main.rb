require 'thor'
require 'pry'
require 'toml'
require_relative './proctor.rb'

class MyCLI < Thor
  desc "repl", "Runs the quiz"
  def repl(file_name)
    proctor = Proctor.load_quiz_from_file(file_name)

    loop do
      question = proctor.current_question

      # ran out of questions
      if question.nil?
        say("great job run it again you got #{proctor.score}/#{proctor.quiz_length}")
        break
      end

      # the questioning continues
      say(question.text)
      print_table(question.answers)
      answer = ask("what do you think? >>").to_i

      correct = proctor.grade_and_proceed(answer)

      if correct
        say(proctor.reply_success)
      else
        say(proctor.reply_failure)
      end
    end
  end
end

MyCLI.start(ARGV)
