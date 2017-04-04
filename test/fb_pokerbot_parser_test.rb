require 'test_helper'

class FbPokerbotParserTest < Minitest::Test

  def setup
  end


  def test_card_syntax
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

    # test only 1 card
    # test only 3 cards
    # test only 2 cards
    # test ignore non-cards
  end
  def test_flop_cards_must_have_3_cards
    result = FbPokerbotParser::MessageParser.new(".test-flop-cards ks Qh 5c")
    assert_equal ['Ks', 'Qh', '5c'], result.flop
    result = FbPokerbotParser::MessageParser.new(".test-flop-cards ksQh5c")
    assert_equal ['Ks', 'Qh', '5c'], result.flop
    result = FbPokerbotParser::MessageParser.new(".test-flop-cards ksQh")
    assert_equal [], result.flop;

  end

  def test_seat_action
    result = FbPokerbotParser::MessageParser.new(".test-action utg b 100")
    assert_equal 1, result.actions.count
    assert_equal 'utg', result.actions.first.fetch(:seat)
    assert_equal :bet, result.actions.first.fetch(:action)
    assert_equal 100, result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action utg1 bet 100")
    assert_equal 1, result.actions.count
    assert_equal 'utg1', result.actions.first.fetch(:seat)
    assert_equal :bet, result.actions.first.fetch(:action)
    assert_equal 100, result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action utg2 c")
    assert_equal 1, result.actions.count
    assert_equal 'utg2', result.actions.first.fetch(:seat)
    assert_equal :call, result.actions.first.fetch(:action)
    assert_nil result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action utg3 call")
    assert_equal 1, result.actions.count
    assert_equal 'utg3', result.actions.first.fetch(:seat)
    assert_equal :call, result.actions.first.fetch(:action)
    assert_nil result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action lj f")
    assert_equal 1, result.actions.count
    assert_equal 'lj', result.actions.first.fetch(:seat)
    assert_equal :fold, result.actions.first.fetch(:action)
    assert_nil result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action hj fold")
    assert_equal 1, result.actions.count
    assert_equal 'hj', result.actions.first.fetch(:seat)
    assert_equal :fold, result.actions.first.fetch(:action)
    assert_nil result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action co ch")
    p result.actions
    assert_equal 1, result.actions.count
    assert_equal 'co', result.actions.first.fetch(:seat)
    assert_equal :check, result.actions.first.fetch(:action)
    assert_nil result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action btn check")
    assert_equal 1, result.actions.count
    assert_equal 'btn', result.actions.first.fetch(:seat)
    assert_equal :check, result.actions.first.fetch(:action)
    assert_nil result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action bb r 2")
    assert_equal 1, result.actions.count
    assert_equal 'bb', result.actions.first.fetch(:seat)
    assert_equal :raise, result.actions.first.fetch(:action)
    assert_equal 2, result.actions.first.fetch(:amount)

    result = FbPokerbotParser::MessageParser.new(".test-action sb raise 12")
    assert_equal 1, result.actions.count
    assert_equal 'sb', result.actions.first.fetch(:seat)
    assert_equal :raise, result.actions.first.fetch(:action)
    assert_equal 12, result.actions.first.fetch(:amount)
  end

  def test_default_action_with_all_keyword
    result = FbPokerbotParser::MessageParser.new(".test-action all c")
    assert_equal 1, result.actions.count
    assert_equal 'all', result.actions.first.fetch(:seat)
    assert_equal :call, result.actions.first.fetch(:action)

    result = FbPokerbotParser::MessageParser.new(".test-action all call")
    assert_equal 1, result.actions.count
    assert_equal 'all', result.actions.first.fetch(:seat)
    assert_equal :call, result.actions.first.fetch(:action)

    result = FbPokerbotParser::MessageParser.new(".test-action all fold")
    assert_equal 1, result.actions.count
    assert_equal 'all', result.actions.first.fetch(:seat)
    assert_equal :fold, result.actions.first.fetch(:action)

    result = FbPokerbotParser::MessageParser.new(".test-action all f")
    assert_equal 1, result.actions.count
    assert_equal 'all', result.actions.first.fetch(:seat)
    assert_equal :fold, result.actions.first.fetch(:action)

  end

  def test_default_action_with_no_keyword
    result = FbPokerbotParser::MessageParser.new(".test dflt_action call")
    assert_equal 1, result.actions.count
    assert_equal 'all', result.actions.first.fetch(:seat)
  end

  def test_multiple_seat_actions 
    result = FbPokerbotParser::MessageParser.new(".test dflt_action sb raise 12 bb call utg1 f")
    assert_equal 3, result.actions.count
    assert_equal ['sb', 'bb', 'utg1'], result.actions.map {|x| x.fetch(:seat)}
  end

  # new hand

  def test_new_hand_command_syntax 
    result = FbPokerbotParser::MessageParser.new("nh")
    assert_equal :new_hand, result.command
    p result.command

    result = FbPokerbotParser::MessageParser.new("new 2/5")
    assert_equal :new_hand, result.command
    p result.command

    result = FbPokerbotParser::MessageParser.new("n 2/5")
    assert_equal :new_hand, result.command
    p result.command
  end

  def test_new_hand_options_syntax
  end

  def test_amount
    result = FbPokerbotParser::MessageParser.new(".test amount 100")
    p result.amount
  end


end
