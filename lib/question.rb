class Question < ActiveRecord::Base
  belongs_to(:survey)
  validates(:question, :presence => true)
  has_many(:answers)
  has_many(:responses)

  def percents
  return_hash = {}
  total_responses = self.responses.length
  answers.each do |answer|
    answer_count = Response.where(:answer_id => answer.id).length
    if total_responses > 0
      percent = 100*answer_count/total_responses
    else
      percent = 0
    end
    return_hash.store(answer.answer, percent)
    end
  return_hash
end

end
