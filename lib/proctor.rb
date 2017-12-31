require_relative './question.rb'

class Proctor
  attr_reader :score, :reply_success, :reply_failure

  def initialize(question_set, responses)
    @reply_success = responses["success"]
    @reply_failure = responses["failure"]
    @questions = question_set
    @position = 0
    @score = 0
  end

  def self.load_quiz_from_file(quiz_file)
    raw_set = TOML.load_file(quiz_file)

    question_set = raw_set["questions"].map do |raw|
      Question.new(raw["question"], raw["choices"], raw["correct"])
    end

    responses = raw_set["responses"]

    Proctor.new(question_set, responses)
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
