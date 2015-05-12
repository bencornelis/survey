require "spec_helper"

describe(Survey) do
  it("can list the questions") do
    survey = Survey.create(name: "Favorite foods")
    question = Question.create(question: "What's your favorite fruit?", survey_id: survey.id)
    expect(survey.questions).to(eq([question]))
  end
end
