class CreateTableAnswers < ActiveRecord::Migration
  def change
    create_table(:answers) do |t|
      t.column(:answer, :string)
      t.column(:question_id, :int)

      t.timestamps()
    end
  end
end
