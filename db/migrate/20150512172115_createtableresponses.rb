class Createtableresponses < ActiveRecord::Migration
  def change
    create_table(:responses) do |r|
      r.column(:question_id, :int)
      r.column(:respondent_id, :int)
      r.column(:answer_id, :int)
    end
  end
end
