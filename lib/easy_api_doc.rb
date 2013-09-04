require "easy_api_doc/engine"
require "easy_api_doc/options"
require "easy_api_doc/cancan"
require "configuration"
require "configurable"

module EasyApiDoc
  def self.options(&block)
    block.call(EasyApiDoc::Options)
  end
end
