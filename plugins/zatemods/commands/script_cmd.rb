module AresMUSH
  module Zatemods
    class ScriptCmd
      include CommandHandler

      #attr_accessor :mode

      # def parse_args
      #   case cmd.switch
      #   when "all"
      #     self.mode = :all
      #   when "open"
      #     self.mode = :open
      #   when "unshared"
      #     self.mode = :unshared
      #   else
      #     self.mode = :active
      #   end
      # end

      def handle
        client.emit "Implment me"

        #   if (self.mode == :active)
        #     scenes = Scene.all.select { |s| !s.completed }.sort_by { |s| s.is_private? ? s.id.to_i + 1000 : s.id.to_i}
        #     template = SceneListTemplate.new(scenes, enactor)
        #   elsif (self.mode == :open)
        #     scenes = Scene.all.select { |s| !s.completed && !s.is_private? }.sort_by { |s| s.id.to_i}
        #     template = SceneListTemplate.new(scenes, enactor)
        #   else

        #     scenes = Scene.all.select { |s| Scenes.can_read_scene?(enactor, s) }.sort_by { |s| s.id.to_i }.reverse

        #     if (self.mode == :unshared)
        #       scenes = scenes.select { |s| !s.shared && s.participants.include?(enactor) }.sort_by { |s| s.id.to_i }.reverse
        #     end

        #     paginator = Paginator.paginate(scenes, cmd.page, 25)
        #     template = SceneSummaryTemplate.new(paginator)

        #   end
        #   client.emit template.render
      end
    end
  end
end
