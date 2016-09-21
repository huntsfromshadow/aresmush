module AresMUSH
  module FS3Combat
    class CombatLuckCmd
      include CommandHandler
      include CommandRequiresLogin
      include CommandRequiresArgs
      include NotAllowedWhileTurnInProgress
      
      attr_accessor :reason
      
      def initialize
        self.required_args = ['reason']
        self.help_topic = 'combat'
        super
      end
      
      def check_reason
        reasons = ["Initiative", "Attack", "Defense"]
        return t('fs3combat.invalid_luck', :reasons => reasons.join(", ")) if !reasons.include?(self.reason)
        return nil
      end
      
      def check_points
        return t('fs3combat.no_luck') if FS3Luck::Api.luck(client.char) <= 1
        return nil
      end
      
      def crack!
        self.reason = titleize_input(cmd.args)
      end

      def handle
        FS3Combat.with_a_combatant(client.name, client) do |combat, combatant|
          
          FS3Luck::Api.spend_luck(client.char, 1)
          client.char.save
          
          combatant.luck = self.reason
          combatant.save
          
          combat.emit t('fs3combat.spending_luck', :name => client.name, :reason => self.reason)
        end
      end
    end
  end
end