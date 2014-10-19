class Task < ActiveRecord::Base
  state_machine :initial => :start do
    after_transition :event_log
    before_transition :update_index
    event :apply do  
      transition :start => :apply
    end

    event :assign do
      transition :apply => :assigned
    end

    event :pass do  
      transition :assigned => :pass
    end

    event :back do  
      transition :assigned => :start
    end  
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
