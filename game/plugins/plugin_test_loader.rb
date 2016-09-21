require "aresmush"

def self.plugin_files(name = "*")
  dir = File.join(File.dirname(__FILE__), "*", "**", "*.rb")
  all_files = Dir[dir]  
  all_files.select { |f| !/_spec[s]*.rb*/.match(f) }
end

plugin_files.sort.each do |f|
  load f
end

module AresMUSH
  
  module CommandHandlerTestHelper
    
    attr_accessor :client, :char, :cmd, :handler
    
    def init_handler(handler_class, cmd_text)
      @client = double
      @char = double
      SpecHelpers.setup_mock_client(@client, @char)
      
      @cmd = Command.new(cmd_text)
      
      @handler = handler_class.new
      @handler.client = @client
      @handler.cmd = @cmd
    end        
      
    shared_examples "a plugin that requires login" do
      it "should include the login validator" do
        handler.methods.should include :check_1_for_login
      end
    end
  end 
end
