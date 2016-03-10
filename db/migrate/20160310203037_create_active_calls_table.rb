class CreateActiveCallsTable < ActiveRecord::Migration
  def change
    create_table :active_calls do |t|
      t.string  :agent_id,      null: false
      t.string  :conference_id, null: false
      t.timestamps null: false
    end
  end
end
