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
    proctor = Proctor.new(
      [
        Question.new("What does h do?",
          ['goes around',
           'moves cursor left',
           'executes sys call',
           'moves cursor down'],
           2),
        Question.new("What does k do?",
          ['goes around',
           'moves cursor left',
           'executes sys call',
           'moves cursor up'],
           4)
      ]
    )

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
        say("you're a vim winner")
      else
        say("unfortunately that is the incorrect answer, please please please try again")
      end
    end
  end
end

class Question
  attr_reader :text, :correct, :answers

  def initialize(text, answer_opts, correct)
    @text = text
    @answers = answer_opts.map.with_index{ |a, i| [i+1, *a]}
    @correct = correct
  end

  def answer_is_correct?(selected_answer)
    selected_answer == @correct
  end
end

class Proctor
  attr_reader :score

  def initialize(question_set)
    @questions = question_set
    @position = 0
    @score = 0
  end

  def grade_and_proceed(answer)
    correct = current_question.answer_is_correct?(answer)
    @score += 1 if correct
    @position += 1
    correct
  end

  def current_question
    @questions[@position]
  end

  def quiz_length
    @questions.length
  end
end

MyCLI.start(ARGV)
