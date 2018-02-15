RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before do
  	FactoryBot.factories.clear
    FactoryBot.find_definitions
  end
end
