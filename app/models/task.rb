class Task < ActiveRecord::Base
  state_machine :initial => :init do
    after_transition :event_log
    before_transition :update_index
    event :created do  
      transition :init => :created
    end

    event :question do  
      transition :created => :question
    end

    event :answer do
      transition :question => :answered
    end

  end

  def attachments
    BpmAttachment.where(:process_id=>self.id)
  end

  def update_index
    self.index = self.index + 1
    self.save
  end

  def event_log(transition)
  	event = EventLog.new
  	event.task_id = self.id
  	event.role_id = self.role_id
    event.index = self.index
  	event.username = self.username
  	event.operation = transition.event
    event.from = transition.from
    event.to = transition.to
  	event.save
  end
end
