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
