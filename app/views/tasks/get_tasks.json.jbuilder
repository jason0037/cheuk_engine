json.array!(@tasks) do |task|
  json.extract! task, :id,:task_type,:role_id,:username,:index,:state,:created_at
  json.attachments task.attachments
end
