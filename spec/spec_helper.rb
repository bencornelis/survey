ENV['RACK_ENV'] = 'test'

require('sinatra/activerecord')
require "question"
require "survey"
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
  end
end
