module AresMUSH
  module Friends
    class FriendAddCmd
      include CommandHandler
      include CommandRequiresLogin
      include CommandRequiresArgs
      
      attr_accessor :name
      
      def initialize
        self.required_args = ['name']
        self.help_topic = 'friends'
        super
      end

      def crack!
        self.name = titleize_input(cmd.args)
      end
      
      def handle
        result = ClassTargetFinder.find(friend_name, Character, nil)
        if (!result.found?)
          client.emit_failure result.error
          return
        end
        friend = result.target

        if (char.friends.include?(friend))
          return t('friends.already_friend', :name => friend_name)
        end
        friendship = Friendship.new(:character => char, :friend => friend)
        friendship.save!
        client.emit_success t('friends.friend_added', :name => self.name)
      end
    end
  end
end
