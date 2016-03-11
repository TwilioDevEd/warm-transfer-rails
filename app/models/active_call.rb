class ActiveCall < ActiveRecord::Base
  scope :with_agent_id, -> (agent_id) { where(agent_id: agent_id) }
end
