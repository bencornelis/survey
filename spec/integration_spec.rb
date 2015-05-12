require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a question to a survey', {:type => :feature}) do
  it('lets an admin add a question to a survey') do
    survey = Survey.create(name: "Testing", description: "This is a test survey")
    visit("/surveys/#{survey.id}")
    fill_in("question", :with => "Why is the sky blue?")
    click_button("Add question")
    expect(page).to(have_content("Why is the sky blue?"))
  end
  it('lets an admin add an answer to a question') do
    survey = Survey.create(name: "Testing", description: "This is a test survey")
    question = survey.questions.create(:question => "Testing?")
    visit("/surveys/#{survey.id}")
    fill_in("answer/#{question.id}", :with => "Because.")
    click_button("Submit/#{question.id}")
    expect(page).to have_content("Because.")
  end
end
