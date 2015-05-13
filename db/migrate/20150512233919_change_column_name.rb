class ChangeColumnName < ActiveRecord::Migration
  def change
    remove_column(:questions, :type, :string)
    add_column(:questions, :q_type, :string)
  end
end
