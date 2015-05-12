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
    return_hash.store(answer, 100*answer_count/total_responses)
    end
  return_hash
end

end
