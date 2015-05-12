class Respondent < ActiveRecord::Base
  has_many(:responses)
  has_many(:questions, through: :responses)
  has_many(:answers, through: :responses)
end
