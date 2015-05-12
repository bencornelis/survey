require "spec_helper"

describe(Answer) do
  it("has one question") do
    question = Question.create(question: "Favorite Food?")
    question2 = Question.create(question: "favorite movie?")
    answer = Answer.create(answer: "What's your favorite movie?", question_id: question2.id)
    expect(answer.question).to eq(question2)
  end
end
