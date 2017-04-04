$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fb_pokerbot_parser'

require 'minitest/autorun'
require 'active_support'
require 'active_support/test_case'
require 'mocha/mini_test'

ActiveSupport::TestCase.test_order = :random

class ActiveSupport::TestCase
  
end