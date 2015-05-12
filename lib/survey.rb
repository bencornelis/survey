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

end
