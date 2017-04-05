
class FbPokerbotParser::MessageParser

  attr_accessor :command, 
                :options, 
                :cards, 
                :actions, 
                :hole_cards, 
                :flop, :turn, :river,
                :amount,
                :blinds


  COMMANDS = {
    "n"        => :new_hand,
    "nh"       => :new_hand,
    "new"      => :new_hand,
    "nt"       => :new_tourney_hand,
    "nht"      => :new_tourney_hand,
    "h"        => :hole,
    "hole"     => :hole,
    "p"        => :preflop_action,
    "pre"      => :preflop_action,
    "preflop"  => :preflop_action,
    "f"        => :flop,
    "flop"     => :flop,
    "fa"       => :flop_action,
    "t"        => :turn,
    "turn"     => :turn,
    "ta"       => :turn_action,
    "r"        => :river,
    "river"    => :river,
    "ra"       => :river_action,
    "sh"       => :showdown,
    "show"     => :showdown,
    "showdown" => :showdown,
    "c"        => :set,
    "config"   => :set,
    "set"      => :set 
  }

  ACTIONS = {
    'b'     => :bet,
    'bet'   => :bet,
    'c'     => :call,
    'call'  => :call,
    'f'     => :fold,
    'fold'  => :fold,
    'r'     => :raise,
    'raise' => :raise,
    'ch'    => :check,
    'check' => :check,
    'm'     => :muck,
    'muck'  => :muck
  }

%%{
  machine pokerbot;

  action parseCard {
    parseCard(data[cp..(p-1)].pack('c*').strip)
    cp = p
  }
  action setFlop {
    @flop = @cards if @cards.count == 3
  }
  action setHoleCards {
    @hole_cards = @cards if @cards.count == 2
  }

  action parseAmount {
    value = data[cp..(p-1)].pack('c*').strip
    @amount = value.to_i
    cp = p
  }

  action parseBlinds {
    parseBlinds(data[cp..(p-1)].pack('c*').strip)
    cp = p
  }

  action parseBigBlind {
    parseBigBlind(data[cp..(p-1)].pack('c*').strip)
    cp = p
  }

  action parseSmallBlind {
    value = data[cp..(p-1)].pack('c*').strip
    @blinds[:sb] = value.to_i
    cp = p
  }

  action parseAnte {
    value = data[cp..(p-1)].pack('c*').strip
    @blinds[:ante] = value.to_i
    cp = p
  }
  
  action extractSeatAction {
    value = data[cp..p].pack('c*').strip
    seat, action, amount = value.split(' ')
    amount = amount.to_i unless amount.nil?
    @actions << {seat: seat, action: ACTIONS.fetch(action,nil), amount: amount}
    cp = p
  }

  action extractDefaultAction {
    value = data[cp..p].pack('c*').strip
    action = value.split(" ").last
    @actions << {seat: 'all', action: ACTIONS.fetch(action,nil), amount: nil}
    cp = p
  }

  space_or_end = space+ | zlen;

  # card definitions
  suit       = ('s'|'S'|'h'|'H'|'d'|'D'|'c'|'C'){1};
  cardval    = ('a'|'A'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'|'10'|'j'|'J'|'q'|'Q'|'k'|'K'){1};
  card       = (cardval.suit){1} %parseCard;
  cards      = (card space_or_end)+;
  hole_cards = (card space_or_end){2} %setHoleCards;
  flop_cards = (card space_or_end){3} %setFlop;

  # seat definitions
  seat       = 'utg'|'utg1'|'utg2'|'utg3'|'lj'|'hj'|'co'|'btn'|'sb'|'bb';
  seat_pos   = '1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'|'10';

  # action definitions
  bet_action   = ('b'|'bet') . space+ . digit+;
  call_action  = ('c'|'call');
  check_action = ('ch'|'check');
  fold_action  = ('f'|'fold');
  raise_action = ('r'|'raise') . space+ . digit+;
  muck_action  = ('m'|'muck');
  actions      = (bet_action|call_action|check_action|fold_action|muck_action|raise_action);
  dflt_action  = ('all'.space+)? (call_action|fold_action|check_action|muck_action)  %extractDefaultAction;
  seat_action  = (seat.space+.actions %extractSeatAction) | dflt_action;
  seat_actions = seat_action (space+ seat_action)*;

  # nh options definitions
  # blinds 10/20/40/80  or 1000/2000/100 (tourney)
  # bb xxx sb xxx a|ante xx
  blinds       = digit+ . '/' . digit+ ('/'.digit+)* %parseBlinds;
  big_blind    = 'bb' . space+ . digit+ >{cp = p} %parseBigBlind;
  small_blind  = 'sb' . space+ . digit+ >{cp = p} %parseSmallBlind;
  ante         = ('a'|'ante').space+.digit+ >{cp = p} %parseAnte;
  straddles    = 'straddle'.space+.digit+;


  cmd_nh    = 'n'|'nh'|'new' >{ @command = COMMANDS['nh']; cp = p };
  cmd_nth   = 'nt'|'nht' >{ @command = COMMANDS['nht']; cp = p };
  cmd_hole  = 'h'|'hole' >{ @command = COMMANDS['h']; cp = p };
  cmd_pre   = 'p'|'pre'|'preflop' >{ @command = COMMANDS['pre']; cp = p };
  cmd_flop  = 'f'|'flop' >{ @command = COMMANDS['flop']; cp = p };
  cmd_fa    = 'fa' >{ @command = COMMANDS['fa']; cp = p };
  cmd_turn  = 't'|'turn' >{ @command = COMMANDS['turn']; cp = p };
  cmd_ta    = 'ta' >{ @command = COMMANDS['ta']; cp = p };
  cmd_river = 'r'|'river' >{ @command = COMMANDS['river']; cp = p };
  cmd_ra    = 'ra' >{ @command = COMMANDS['ra']; cp = p };
  cmd_show  = 'sh'|'show'|'showdown' >{ @command = COMMANDS['sh']; cp = p };
  cmd_edit  = 'e'|'edit' >{ @command = COMMANDS['e']; cp = p };
  cmd_set   = 'c'|'config'|'set' >{ @command = COMMANDS['set']; cp = p };
  
  nh_options = any+;

  #new_hand  = cmd_nh space %extractCommand space nh_options %extractOptions;


  # commands     = cmd_newhand | 
  #                cmd_newtourneyhand | 
  #                cmd_hero | 
  #                cmd_preflop_action |
  #                cmd_flop | 
  #                cmd_flop_action | 
  #                cmd_turn | 
  #                cmd_turn_action | 
  #                cmd_river |
  #                cmd_river_action |
  #                cmd_showdown |
  #                cmd_edit |
  #                cmd_set; 

  main := |*
    cmd_nh;
    '.test card'           space >{cp = p} card;
    '.test hole-cards'     space >{cp = p} hole_cards;
    '.test flop-cards'     space >{cp = p} flop_cards;
    '.test seat_action'    space >{cp = p} seat_action;
    '.test default_action' space >{cp = p} dflt_action;
    '.test seat_actions'   space >{cp = p} seat_actions;
    '.test blinds'         space >{cp = p} blinds;
    '.test big_blind'      space >{cp = p} big_blind;
    '.test small_blind'    space >{cp = p} small_blind;
    '.test ante'           space >{cp = p} ante;
  *|;

}%%

  def initialize(data)
    %% write data;
    data = data.unpack("c*") if data.is_a?(String)
    eof  = data.length
    cp   = 0

    @command    = ""
    @cards      = []
    @options    = {}
    @actions    = []
    @flop       = []
    @turn       = []
    @river      = []
    @hole_cards = []
    @blinds     = {}
    @amount     = nil

    %% write init;
    %% write exec;
  end

  def parseCard(card)
    suit = card[-1..-1]
    val  = card[0..-2]
    @cards << "#{val.upcase}#{suit.downcase}"
  end

  def parseBlinds(data)
    sb, bb, *straddles = data.split("/")
    @blinds[:sb] = sb.to_i
    @blinds[:bb] = bb.to_i
    return if straddles.empty?
    if straddles.count == 1 && straddles.first.to_i < @blinds[:bb]
      @blinds[:ante] = straddles.first.to_i
    else
      @blinds[:straddle] = straddles.map(&:to_i)
    end
  end

  def parseBigBlind(data)
    @blinds[:bb] = data.to_i
    @blinds[:sb] = (@blinds[:bb] / 2) if @blinds[:sb].nil?
  end

    
end