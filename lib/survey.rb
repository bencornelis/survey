class Survey < ActiveRecord::Base
  has_many(:questions)

  validates(:name, length: {
    minimum: 5,
    maximum: 50
  })

  validates(:description, length: {
    minimum: 10,
    maximum: 100
  })

  def responses
    response_array = []
    questions.each do |q|
      response_array += q.responses
    end
    response_array
  end

end
