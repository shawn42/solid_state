module SolidState
  class State
    attr_reader :stated
    def initialize(stated)
      @stated = stated
    end
  end
  class InvalidStateError < RuntimeError; end

  # On include, setup all required methods
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods

    # Define a state
    def state(name, &block)
      klass = const_set("State_#{name}", Class.new(State))
      klass.send(:define_method, :state_name) { name }
      klass.class_eval(&block)
    end

    # Define the starting state
    def starting_state(name)
      self.send(:define_method, :__start_state) { name }
    end

    def transition(pair, &blk)
      pair.each do |from, to|
        @__transitions ||= {} 
        @__transitions[from] ||= {} 
        @__transitions[from] = blk
      end
    end
  end

  module InstanceMethods

    # What's the current state
    def current_state
      got = @__current_state ||= (self.respond_to?(:__start_state) ?
                                  self._find_state(self.__start_state) : nil)
      got ? got.state_name : nil
    end

    # Change the current state
    def change_state!(name)
      from_state = current_state

      unless from_state == name
        trans = self.class.instance_variable_get('@__transitions')[from_state]
        if trans
          tran = trans[name]
          tran.call if tran
        end
      end
      found = _find_state(name)
      raise InvalidStateError.new("No state defined with name #{name}") if found.nil?

      @__current_state = found
    end

    # Proxy off any unknown method into the current state object
    def method_missing(name, *args)
      current_state

      if @__current_state.respond_to?(name)
        @__current_state.send(name, *args)
      else
        super
      end
    end

    protected

    def _known_states
      @__known_states ||= {}
    end

    def _find_state(name)
      const_name = "State_#{name}"
      self._known_states ||= {}

      self._known_states[name] ||= _get_state_const(const_name)
    end

    # To allow for subclasses to use superclass states, we need
    # to traverse up the heirarchy looking for the constants
    # defined. This works because klass.ancectors[0] == klass,
    # so if the const is defined on this klass, we get it quickly.
    def _get_state_const(const_name)
      self.class.ancestors.each do |klass|
        if klass.const_defined?(const_name)
          return klass.const_get(const_name).new self
        end
      end

      nil
    end

  end

end
