module InstanceCounter
  @@instance_counter = 0

  def self.included(base)  
    base.extend ClassMethods
    base.include InstanceMethods
  end
  
  module ClassMethods
    def instances
      @@instance_counter
    end
  end
  
  module InstanceMethods
    private
    def register_instance
      @@instance_counter += 1
    end
  end
end