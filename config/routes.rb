Rails.application.routes.draw do
  root 'home#index'

  post 'conference/wait'                           => 'conference#wait'
  post 'conference/connect/client'                 => 'conference#connect_client'
  post 'conference/:conference_id/connect/agent1/' => 'conference#connect_agent1', as: :conference_connect_agent1
  post 'conference/:conference_id/connect/agent2'  => 'conference#connect_agent2', as: :conference_connect_agent2
  post 'conference/:agent_id/call'                 => 'conference#call_agent2',    as: :conference_call_agent2

  post ':agent_id/token'                           => 'token#generate'

end
