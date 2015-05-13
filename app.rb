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
  @survey.questions.create({:question => params.fetch("question"), :q_type => params.fetch("question_type")})
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
  question_id = @survey.questions[session[:question_index]].id
  @question = Question.find(question_id)
  @percent_complete = 0
  @question
  erb(:take_survey)
end

get("/take/:survey_id") do |id|
  @survey = Survey.find(id.to_i)
  @percent_complete = 100*session[:question_index]/@survey.questions.length
  if session[:question_index] != @survey.questions.length
  question_id = @survey.questions[session[:question_index]].id
  @question = Question.find(question_id)
end
  erb(:take_survey)
end

post("/nextquestion/:survey_id") do |id|
  survey = Survey.find(id.to_i)
  question_id = survey.questions[session[:question_index]].id
  @question = Question.find(question_id)
  respondent_id = session[:respondent_id]
    if params.fetch("question_type") == "singlechoice"
      answer_id = params["answer_id"]
    Response.create({:question_id => question_id, :answer_id => answer_id, :respondent_id => respondent_id})
    elsif params.fetch("question_type") == "multichoice"
    answer_ids = params.fetch("answer_ids")
    answer_ids.each do |answer_id|
      Response.create({:question_id => question_id, :answer_id => answer_id.to_i, :respondent_id => respondent_id})
    end
    elsif params.fetch("question_type") == "open"
    answer = Answer.create(:answer => params.fetch("answer"))
    Response.create({:question_id => question_id, :answer_id => answer.id, :respondent_id => respondent_id})
    end
  session[:question_index] += 1
  redirect "/take/#{id}"
end

get("/surveys/:survey_id/statistics") do |id|
  @survey = Survey.find(id.to_i)
  erb(:statistics)
end
