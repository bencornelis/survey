require "spec_helper"

describe(Question) do
  it("has one survey") do
    survey1 = Survey.create(name: "Favorite Foods", description:
    "What is your favorite food survey")
    survey2 = Survey.create(name: "Favorite Movies", description: "asks respondents for their favorite movie")
    question = Question.create(question: "What's your favorite movie?", survey_id: survey2.id)
    expect(question.survey).to eq(survey2)
  end

  it("validates the presence of a question") do
    question = Question.new(question: "")
    expect(question.save).to(eq(false))
    expect(Question.all).to(eq([]))
  end
  it("validates the presence of a question") do
    question = Question.create(question: "")
    expect(question.valid?).to(eq(false))
  end
end
