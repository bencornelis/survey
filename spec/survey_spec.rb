require "spec_helper"

describe(Survey) do
  it("can list the questions") do
    survey = Survey.create(name: "Favorite foods", description: "Asks respondents for their favorite foods")
    question = Question.create(question: "What's your favorite fruit?", survey_id: survey.id)
    expect(survey.questions).to(eq([question]))
  end
  it("must have a name at least 5 characters in length") do
    survey = Survey.create(name: "Dave")
    expect(survey.valid?).to(eq(false))
  end
  it("cannot have a name more than 50 characters long") do
    survey = Survey.create(name: "a" * 51)
    expect(survey.valid?).to(eq(false))
  end
end
