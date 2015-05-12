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

  describe("#responses") do
    it("returns all the responses for the survey") do
      survey = Survey.create(name: "Favorite foods", description: "Asks respondents for their favorite foods")
      test_respondent = Respondent.create(name: "Steve Jobs")
      test_question1 = Question.create(question: "What's your favorite color?", survey_id: survey.id)
      test_question2 = Question.create(question: "What's the meaning of life?", survey_id: survey.id)
      test_answer1 = Answer.create(answer: "Blue", question_id: test_question1.id)
      test_answer2 = Answer.create(answer: "idk", question_id: test_question2.id)
      test_response1 = Response.create(question_id: test_question1.id, respondent_id:test_respondent.id, answer_id: test_answer1.id)
      test_response2 = Response.create(question_id: test_question2.id, respondent_id: test_respondent.id, answer_id: test_answer2.id)
      expect(survey.responses).to(eq([test_response1, test_response2]))
    end
  end
end
