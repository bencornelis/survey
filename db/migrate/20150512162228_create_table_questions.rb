class CreateTableQuestions < ActiveRecord::Migration
  def change
    create_table(:questions) do |q|
      q.column(:question, :string)

      q.timestamps()
    end
  end
end
