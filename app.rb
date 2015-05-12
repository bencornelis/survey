require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require './lib/answer'
require './lib/question'
require './lib/respondent'
require './lib/response'
require './lib/survey'
also_reload('lib/**/*.rb')
require('pry')
require('pg')

enable :sessions

helpers do
  def logged_in?
    session[:user_type] != nil
  end
end

get('/') do
  erb(:index)
end

post('/login') do
  session[:user_type] = params.fetch("user_type")
  redirect '/'
end


get('/foo') do
  session[:user_type] = nil
  redirect '/'
end

get('/surveys') do
@surveys=Survey.all
erb(:surveys)
end

get('/surveys/new') do
erb(:survey_form)
end

post('/surveys') do
  Survey.create({:name => params.fetch('name'), :description => params.fetch('description')})
  @surveys=Survey.all
  erb(:surveys)
end

get('/surveys/:id') do |id|
  @survey = Survey.find(id.to_i)
  erb(:survey)
end

post('/surveys/:id') do |id|
  @survey = Survey.find(id.to_i)
  @survey.questions.create(:question => params.fetch("question"))
  erb(:survey)
end

post("/questions/:question_id") do |id|
  question = Question.find(id.to_i)
  question.answers.create(answer: params.fetch("answer"))
  survey_id = question.survey.id
  redirect "/surveys/#{survey_id}"
end

get("/start/:id") do |id|
  @survey = Survey.find(id.to_i)
  erb(:start_survey)
end

post("/take/:survey_id") do |id|
  session[:question_index] = 0
  respondent = Respondent.create(:name => params.fetch("name"))
  session[:respondent_id] = respondent.id
  @survey = Survey.find(id.to_i)
  erb(:take_survey)
end

get("/take/:survey_id") do |id|
  @survey = Survey.find(id.to_i)
  erb(:take_survey)
end

post("/nextquestion/:survey_id") do |id|
  survey = Survey.find(id.to_i)
  question_id = survey.questions[session[:question_index]].id
  answer_id = params["answer_id"]
  respondent_id = session[:respondent_id]
  Response.create({:question_id => question_id, :answer_id => answer_id, :respondent_id => respondent_id})
  session[:question_index] += 1
  redirect "/take/#{id}"
end
