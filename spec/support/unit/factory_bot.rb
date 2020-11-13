require 'factory_bot'

require 'account_block/factories'
require 'bx_block_comments/factories'


FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end