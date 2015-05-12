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

  describe("#percents") do
    it("gives the percentage of respondents that chose this answer for its question") do
      question = Question.create(question: "Favorite drink?")
      answer1 = question.answers.create(answer: "coffee")
      answer2 = question.answers.create(answer: "beer")
      answer3 = question.answers.create(answer: "soda")
      respondent1 = Respondent.create(name: "Fred")
      respondent2 = Respondent.create(name: "George")
      question.responses.create(respondent_id: respondent1.id, answer_id: answer1.id)
      question.responses.create(respondent_id: respondent2.id, answer_id: answer2.id)
      expect(question.percents).to(eq({answer1 => 50, answer2 => 50, answer3 => 0}))
     end
  end
end
