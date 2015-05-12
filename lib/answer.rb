class Answer < ActiveRecord::Base
  has_many(:responses)
  belongs_to(:question)
  validates(:answer, presence: true)
end
