require "spec_helper"

describe(Respondent) do
  it("has many responses") do
    test_survey = Survey.create(name: "Test Survey", description: "A test survey that tests things")
    test_respondent = Respondent.create(name: "Steve Jobs")
    test_question1 = Question.create(question: "What's your favorite color?")
    test_question2 = Question.create(question: "What's the meaning of life?")
    test_answer1 = Answer.create(answer: "Blue", question_id: test_question1.id)
    test_answer2 = Answer.create(answer: "idk", question_id: test_question2.id)
    test_response1 = Response.create(question_id: test_question1.id, respondent_id:test_respondent.id, answer_id: test_answer1.id)
    test_response2 = Response.create(question_id: test_question2.id, respondent_id: test_respondent.id, answer_id: test_answer2.id)
    expect(test_respondent.responses).to eq([test_response1, test_response2])
  end
end
