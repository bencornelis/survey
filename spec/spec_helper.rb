ENV['RACK_ENV'] = 'test'

require('sinatra/activerecord')
require "question"
require "survey"
require "answer"
require "respondent"
require "response"
require('rspec')
require('pg')
require('pry')
ActiveRecord::Base.logger = Logger.new(STDOUT)

RSpec.configure do |config|
  config.after(:each) do
    Question.all().each() do |question|
      question.destroy()
    end
    Survey.all().each() do |survey|
      survey.destroy()
    end
    Response.all().each() do |response|
      response.destroy()
    end
    Answer.all().each() do |answer|
      answer.destroy()
    end
    Respondent.all().each() do |respondent|
      respondent.destroy()
    end
  end
end
