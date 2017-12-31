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
