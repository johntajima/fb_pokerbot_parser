require 'test_helper'

class FbPokerbotParserTest < ActiveSupport::TestCase

  def setup
  end


  test "card syntax parsing with .test-card" do
    result = FbPokerbotParser::MessageParser.new(".test-cards 10h")
    assert_equal ['10h'], result.cards

    result = FbPokerbotParser::MessageParser.new(".test-cards 10h10d")
    assert_equal ['10h', '10d'], result.cards
    
    result = FbPokerbotParser::MessageParser.new(".test-cards aC")
    assert_equal ['Ac'], result.cards

    result = FbPokerbotParser::MessageParser.new(".test-cards 5h4D")
    assert_equal ['5h', '4d'], result.cards

    result = FbPokerbotParser::MessageParser.new(".test-cards ks Qh")
    assert_equal ['Ks', 'Qh'], result.cards
  end

  test "new hand syntax nh" do
    result = FbPokerbotParser::MessageParser.new("nh")
    p result
  end

end
