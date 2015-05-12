class AddSurveyColumnToQuestions < ActiveRecord::Migration
  def change
    add_column(:questions, :survey_id, :int)
  end
end
