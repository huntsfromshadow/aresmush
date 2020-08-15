module AresMUSH
  module Zatemods
    class HackingScriptsCmd
      # Borrows heavily from the fs3skill learn command
      include CommandHandler

      def handle
        template = CharacterScriptsTemplate.new enactor, client
        client.emit template.render
      end
    end
  end
end
