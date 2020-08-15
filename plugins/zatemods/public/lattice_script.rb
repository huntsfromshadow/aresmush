module AresMUSH
  class LatticeScript < Ohm::Model
    include ObjectModel

    reference :character, "AresMUSH::Character"
    attribute :name
    #attribute :script_learned, :type => DataType::Boolean, :default => false

    index :name

    # Borows a lot from LearnableAbility from FS3
    attribute :last_learned, :type => Ohm::DataTypes::DataType::Time, :default => Time.now
    attribute :xp, :type => Ohm::DataTypes::DataType::Integer, :default => 0

    def get_config_data
      # It can be in a number of locations so we need to run through them
      val = Global.read_config("zatehacking", "script_library", "weapon", self.name)
      if val.nil?
        val = Global.read_config("zatehacking", "script_library", "other", self.name)
      end

      return val
    end

    # Pull these attributes from the config files.
    def function
      self.get_config_data()["function"]
    end

    def memory_blocks
      self.get_config_data()["memory_blocks"]
    end

    def target
      self.get_config_data()["target"]
    end

    def use_case
      self.get_config_data()["use_case"]
    end

    def combat_enabled
      self.get_config_data()["combat_enabled"]
    end

    def visibility
      self.get_config_data()["visibility"]
    end

    def fork_code
      self.get_config_data()["fork_code"]
    end

    def tier
      fc = self.fork_code
      lst = fc.split(".")
      lst.size
    end

    def learn
      update(last_learned: Time.now)
      update(xp: self.xp + 1)
    end

    def xp_needed
      #For now it's hard coded to 5
      return 5
    end

    def learning_complete?
      self.xp >= self.xp_needed
    end

    def script_learned?
      self.learning_complete?
    end

    def can_learn?
      self.time_to_next_learn <= 0
    end

    def time_to_next_learn
      return 0 if !self.last_learned
      time_left = (Zatemods.days_between_learning * 86400) - (Time.now - self.last_learned)
      [time_left, 0].max
    end

    def days_to_next_learn
      (self.time_to_next_learn / 86400).ceil
    end
  end
end
