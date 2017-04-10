require 'test_helper'

class FbPokerbotParserTest < ActiveSupport::TestCase

  def setup
    @seats = %w| utg utg1 utg2 utg3 lj hj co btn sb bb|
  end

  # card 

  test "card parses single card and capitalize value, lowercases suit" do
    msg = FbPokerbotParser::MessageParser.new(".test card 10h")
    assert_equal ['10h'], msg.cards

    msg = FbPokerbotParser::MessageParser.new(".test card aC")
    assert_equal ['Ac'], msg.cards

    msg = FbPokerbotParser::MessageParser.new(".test card Kd")
    assert_equal ['Kd'], msg.cards
  end

  test "#card fails if not valid card syntax" do
    msg = FbPokerbotParser::MessageParser.new(".test card bad")
    assert_equal [], msg.cards
  end

  test "#card supports xx for unknown cards" do
    msg = FbPokerbotParser::MessageParser.new(".test card ax")
    assert_equal ['Ax'], msg.cards
    msg = FbPokerbotParser::MessageParser.new(".test card xc")
    assert_equal ['Xc'], msg.cards
    msg = FbPokerbotParser::MessageParser.new(".test card xx")
    assert_equal ['Xx'], msg.cards
  end
 
  # hole-cards

  test "#hole_cards parses two cards with no space" do
    msg = FbPokerbotParser::MessageParser.new(".test hole-cards 10h10d")
    assert_equal ['10h', '10d'], msg.hole_cards
  end

  test "#hole_cards parses two cards with space" do
    msg = FbPokerbotParser::MessageParser.new(".test hole-cards 10h 10d")
    assert_equal ['10h', '10d'], msg.hole_cards
  end

  test "#hold_cards returns nothing if only 1 card" do
    msg = FbPokerbotParser::MessageParser.new(".test hole-cards 10h")
    assert_equal [], msg.hole_cards
  end

  test "#hold_cards returns two cards if more than 2 cards presented" do
    msg = FbPokerbotParser::MessageParser.new(".test hole-cards 10h 5h 3D")
    assert_equal ['10h', '5h'], msg.hole_cards
  end

  # flop-cards

  test "#flop parses 3 cards with spaces" do
    msg = FbPokerbotParser::MessageParser.new(".test flop-cards 10h 5d 4c")
    assert_equal ["10h", "5d", "4c"], msg.flop
  end

  test "#flop parses 3 cards with no spaces" do
    msg = FbPokerbotParser::MessageParser.new(".test flop-cards asahkD")
    assert_equal ["As", "Ah", "Kd"], msg.flop
  end

  test "#flop parses 3 cards with some spaces" do
    msg = FbPokerbotParser::MessageParser.new(".test flop-cards 10h5d 4c")
    assert_equal ["10h", "5d", "4c"], msg.flop

    msg = FbPokerbotParser::MessageParser.new(".test flop-cards 10h 5d4c")
    assert_equal ["10h", "5d", "4c"], msg.flop
  end
  

  # seat_actions

  test "#seat_actions parses all possible valid seat names, action and amounts" do
    @seats.each do |seat|
      msg = FbPokerbotParser::MessageParser.new(".test seat_action #{seat} call")
      action = msg.actions.first
      assert_equal seat, action.fetch(:seat)
    end

    FbPokerbotParser::MessageParser::ACTIONS.each_pair do |k, v|
      next if v == :bet || v == :raise
      msg = FbPokerbotParser::MessageParser.new(".test seat_action bb #{k}")
      expected = {:seat => "bb", :action => v, :amount => nil}
      assert_equal expected, msg.actions.first
    end

    msg = FbPokerbotParser::MessageParser.new(".test seat_action utg b 100")
    expected = {:seat=>"utg", :action=>:bet, :amount=>100}
    assert_equal expected, msg.actions.first
    
    msg = FbPokerbotParser::MessageParser.new(".test seat_action utg bet 100")
    expected = {:seat=>"utg", :action=>:bet, :amount=>100}
    assert_equal expected, msg.actions.first
    

    msg = FbPokerbotParser::MessageParser.new(".test seat_action utg r 100")
    expected = {:seat=>"utg", :action=>:raise, :amount=>100}
    assert_equal expected, msg.actions.first

    msg = FbPokerbotParser::MessageParser.new(".test seat_action utg raise 100")
    expected = {:seat=>"utg", :action=>:raise, :amount=>100}
    assert_equal expected, msg.actions.first
  end

  test "#seat_actions parses multiple actions" do
    msg = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 btn c sb fold")
    assert_equal 3, msg.actions.count
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100},
      {:seat=>"btn", :action=>:call, :amount=>nil},
      {:seat=>"sb", :action=>:fold, :amount=>nil}
    ]
    assert_equal expected, msg.actions
  end

  test "#seat_actions handles all action without all keyword" do
    msg = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 c")
    assert_equal 2, msg.actions.count
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil}
    ]
    assert_equal expected, msg.actions    
  end

  test "#seat_actions handles multiple actions with all keyword" do
    msg = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 all call btn raise 100 all fold")
    assert_equal 4, msg.actions.count
    
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil},
      {:seat=>"btn", :action=>:raise, :amount=>100},
      {:seat=>"all", :action=>:fold, :amount=>nil}
    ]
    assert_equal expected, msg.actions    
  end

  test "#seat_actions handles multiple actions without all keyword" do
    msg = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 call btn raise 100  fold")
    assert_equal 4, msg.actions.count
    
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil},
      {:seat=>"btn", :action=>:raise, :amount=>100},
      {:seat=>"all", :action=>:fold, :amount=>nil}
    ]
    assert_equal expected, msg.actions    
  end

  test "#seat_actions handles all action as default" do
    msg = FbPokerbotParser::MessageParser.new(".test seat_actions utg b 100 all call")
    assert_equal 2, msg.actions.count
    expected = [
      {:seat=>"utg", :action=>:bet, :amount=>100}, 
      {:seat=>"all", :action=>:call, :amount=>nil}
    ]
    assert_equal expected, msg.actions    
  end

  test "#seat_actions with starting default action and multiple seats" do
    msg = FbPokerbotParser::MessageParser.new(".test seat_actions call utg fold")
    assert_equal 2, msg.actions.count
    expected = [
      {:seat=>"all", :action=>:call, :amount=>nil},
      {:seat=>"utg", :action=>:fold, :amount=>nil} 
    ]
    assert_equal expected, msg.actions    
  end

  # default_actions

  test '#default_action parses default action with all keyword' do
    msg = FbPokerbotParser::MessageParser.new(".test default_action all check")
    expected = {:seat=>"all", :action=>:check, :amount=>nil}
    assert_equal 1, msg.actions.count
    assert_equal expected, msg.actions.first
  end

  test '#default_action parses default action without all keyword' do
    msg = FbPokerbotParser::MessageParser.new(".test default_action call")
    expected = {:seat=>"all", :action=>:call, :amount=>nil}
    assert_equal 1, msg.actions.count
    assert_equal expected, msg.actions.first
  end

  # blinds

  test "#blinds parses 10/20 properly" do
    msg = FbPokerbotParser::MessageParser.new(".test blinds 10/20")
    assert_equal 10, msg.blinds[:sb]
    assert_equal 20, msg.blinds[:bb]
    assert_nil msg.blinds[:ante]
  end

  test "#blinds parse 1000/2000/100 properly for tourneys" do
    msg = FbPokerbotParser::MessageParser.new(".test blinds 1000/2000/100")
    assert_equal 1000, msg.blinds[:sb]
    assert_equal 2000, msg.blinds[:bb]
    assert_equal 100, msg.blinds[:ante]
  end

  test "#blinds parse 10/20/40/50 straddle properly for cash games" do
    msg = FbPokerbotParser::MessageParser.new(".test blinds 1/2/4/8")
    assert_equal 1, msg.blinds[:sb]
    assert_equal 2, msg.blinds[:bb]
    assert_equal [4,8], msg.blinds[:straddle]
  end

  test "#big_blind parses and sets bb and sb properly" do
    msg = FbPokerbotParser::MessageParser.new(".test big_blind bb 2")
    assert_equal 2, msg.blinds[:bb]
    assert_equal 1, msg.blinds[:sb]

    msg = FbPokerbotParser::MessageParser.new(".test big_blind bb 5")
    assert_equal 5, msg.blinds[:bb]
    assert_equal 2, msg.blinds[:sb]
  end

  test "#small_blind parses and sets sb properly" do
    msg = FbPokerbotParser::MessageParser.new(".test small_blind sb 2")
    assert_equal 2, msg.blinds[:sb]
  end

  test "#ante parses and sets ante properly" do
    msg = FbPokerbotParser::MessageParser.new(".test ante ante 100")
    assert_equal 100, msg.blinds[:ante]
  end

  # command status

  test "command with no options assumes command status request" do
    commands = %w| new nt hero pre flop turn river show|
    commands.each do |command|
      msg = FbPokerbotParser::MessageParser.new(command)
      assert msg.status
    end
  end

  # new hand command and options

  test "#new_hand without options assumes status request for new hand command" do
    msg = FbPokerbotParser::MessageParser.new("nh")
    assert_equal :new_hand, msg.command    
    assert msg.status

    msg = FbPokerbotParser::MessageParser.new("new")
    assert_equal :new_hand, msg.command    
    assert msg.status

    msg = FbPokerbotParser::MessageParser.new("n")
    assert_equal :new_hand, msg.command    
    assert msg.status

    msg = FbPokerbotParser::MessageParser.new("new hand")
    assert_equal :new_hand, msg.command    
    assert msg.status
  end

  test "#new_hand with garbage options ignores options" do
    expected = {}
    msg = FbPokerbotParser::MessageParser.new("new hand 11p 55b")
    assert_equal :new_hand, msg.command    
    assert_equal expected, msg.options
  end

  test "#new_hand parses new hand command syntax with player options" do
    msg = FbPokerbotParser::MessageParser.new("nh 9p 4h 3b")

    assert_equal :new_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 4, msg.options[:hero]
    assert_equal 3, msg.options[:button]

    msg = FbPokerbotParser::MessageParser.new("nh 9ph 3b")
    assert_equal :new_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 9, msg.options[:hero]
    assert_equal 3, msg.options[:button]

    msg = FbPokerbotParser::MessageParser.new("nh 9p 3bh")
    assert_equal :new_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 3, msg.options[:hero]
    assert_equal 3, msg.options[:button]    
  end

  test "#new_hand parses hand syntax with blinds and player options" do
    msg = FbPokerbotParser::MessageParser.new("nh 9p 4h 3b 1/2")
    assert_equal :new_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 4, msg.options[:hero]
    assert_equal 3, msg.options[:button]    
    assert_equal 1, msg.blinds[:sb]
    assert_equal 2, msg.blinds[:bb]

    msg = FbPokerbotParser::MessageParser.new("nh 1/2 9p 4h 3b")
    assert_equal 9, msg.options[:players]
    assert_equal 4, msg.options[:hero]
    assert_equal 3, msg.options[:button]    
    assert_equal 1, msg.blinds[:sb]
    assert_equal 2, msg.blinds[:bb]    
  end

  # new hand tourney

  test "#new_hand_tourney parses new hand command syntax with player options" do
    msg = FbPokerbotParser::MessageParser.new("nht 9p 4h 3b")
    assert_equal :new_tourney_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 4, msg.options[:hero]
    assert_equal 3, msg.options[:button]

    msg = FbPokerbotParser::MessageParser.new("nht 9ph 3b")
    assert_equal :new_tourney_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 9, msg.options[:hero]
    assert_equal 3, msg.options[:button]

    msg = FbPokerbotParser::MessageParser.new("nt 9p 3bh")
    assert_equal :new_tourney_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 3, msg.options[:hero]
    assert_equal 3, msg.options[:button]    
  end

  test "#new_hand_tourney parses hand syntax with blinds and player options" do
    msg = FbPokerbotParser::MessageParser.new("nt 1000/2000/100 9p 4h 3b")
    assert_equal :new_tourney_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 4, msg.options[:hero]
    assert_equal 3, msg.options[:button]    
    assert_equal 1000, msg.blinds[:sb]
    assert_equal 2000, msg.blinds[:bb]
    assert_equal 100, msg.blinds[:ante]

    msg = FbPokerbotParser::MessageParser.new("nt 9p 3b 1000/2000/100 4h")
    assert_equal :new_tourney_hand, msg.command
    assert_equal 9, msg.options[:players]
    assert_equal 4, msg.options[:hero]
    assert_equal 3, msg.options[:button]    
    assert_equal 1000, msg.blinds[:sb]
    assert_equal 2000, msg.blinds[:bb]
    assert_equal 100, msg.blinds[:ante]
    
    msg = FbPokerbotParser::MessageParser.new("nt bb 2000 ante 100")
    assert_equal :new_tourney_hand, msg.command
    assert_equal 1000, msg.blinds[:sb]
    assert_equal 2000, msg.blinds[:bb]
    assert_equal 100, msg.blinds[:ante]
  end

  # hero/hole cards & stacks

  test "#hero accepts hole cards and stack size options" do
    msg = FbPokerbotParser::MessageParser.new("hero KdAh 200")
    expected = {:stack => 200}
    assert_equal expected, msg.hero
    assert_equal ["Kd", "Ah"], msg.hole_cards
  end

  # preflop action 

  test "#preflop accepts hole cards and betting action" do
    msg = FbPokerbotParser::MessageParser.new("pre check btn bet 10 fold co call")
    assert_equal :preflop, msg.command
    assert_equal 4, msg.actions.count
    assert_equal [:check, :bet, :fold, :call], msg.actions.map {|x| x.fetch(:action)}
  end


  # flop action

  test "#flop accepts flop cards only" do
    msg = FbPokerbotParser::MessageParser.new("flop ahqhjh")
    assert_equal :flop, msg.command
    assert_equal ["Ah", "Qh", "Jh"], msg.cards
  end

  test "#flop accepts flop cards and actions" do
    msg = FbPokerbotParser::MessageParser.new("flop ahqhjh check btn bet 10 fold")
    assert_equal :flop, msg.command
    assert_equal ["Ah", "Qh", "Jh"], msg.cards
    assert_equal 3, msg.actions.count

    msg = FbPokerbotParser::MessageParser.new("flop check btn bet 10 fold ahqhjh ")
    assert_equal :flop, msg.command
    assert_equal ["Ah", "Qh", "Jh"], msg.cards
    assert_equal 3, msg.actions.count
  end

  test "#flop accepts actions only" do
    msg = FbPokerbotParser::MessageParser.new("flop check btn bet 10 fold")
    assert_equal :flop, msg.command
    assert_equal 3, msg.actions.count
  end

  # turn action

  test "#turn accepts card" do
    msg = FbPokerbotParser::MessageParser.new("turn ah")
    assert_equal :turn, msg.command
    assert_equal ["Ah"], msg.cards
  end

  test "#turn accepts card and seat actions" do
    msg = FbPokerbotParser::MessageParser.new("turn ah check btn bet 10 fold")
    assert_equal :turn, msg.command
    assert_equal ["Ah"], msg.cards
    assert_equal 3, msg.actions.count

    msg = FbPokerbotParser::MessageParser.new("turn check btn bet 10 fold ah ")
    assert_equal :turn, msg.command
    assert_equal ["Ah"], msg.cards
    assert_equal 3, msg.actions.count
  end

  test "#turn accepts seat actions only" do
    msg = FbPokerbotParser::MessageParser.new("turn check btn bet 10 fold")
    assert_equal :turn, msg.command
    assert_equal 3, msg.actions.count
  end

  # river action

  test "#river accepts card" do
    msg = FbPokerbotParser::MessageParser.new("r ah")
    assert_equal :river, msg.command
    assert_equal ["Ah"], msg.cards
  end

  test "#river accepts card and seat actions" do
    msg = FbPokerbotParser::MessageParser.new("river ah check btn bet 10 fold")
    assert_equal :river, msg.command
    assert_equal ["Ah"], msg.cards
    assert_equal 3, msg.actions.count

    msg = FbPokerbotParser::MessageParser.new("river check btn bet 10 fold ah ")
    assert_equal :river, msg.command
    assert_equal ["Ah"], msg.cards
    assert_equal 3, msg.actions.count
  end

  test "#river accepts seat actions only" do
    msg = FbPokerbotParser::MessageParser.new("r check btn bet 10 fold")
    assert_equal :river, msg.command
    assert_equal 3, msg.actions.count
  end

  test "#show accepts seat and card information" do
    msg = FbPokerbotParser::MessageParser.new("sh btn ac kh")
    assert_equal 2, msg.players.fetch(:btn).fetch(:cards).count

    msg = FbPokerbotParser::MessageParser.new("sh btn ac kh co 4d 4h")
    assert_equal ["Ac", "Kh"], msg.players.fetch(:btn).fetch(:cards)
    assert_equal ["4d", "4h"], msg.players.fetch(:co).fetch(:cards)
  end



end
