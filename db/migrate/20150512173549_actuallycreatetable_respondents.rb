class ActuallycreatetableRespondents < ActiveRecord::Migration
  def change
    create_table(:respondents) do |t|
      t.column(:name, :string)

      t.timestamps()
    end
  end
end
