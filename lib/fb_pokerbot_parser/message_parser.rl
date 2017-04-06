
class FbPokerbotParser::MessageParser

  attr_accessor :command, 
                :status,
                :options, 
                :cards, 
                :actions, 
                :hole_cards, 
                :flop, :turn, :river,
                :amount,
                :blinds


  COMMANDS = {
    "nh"       => :new_hand,
    "nt"       => :new_tourney_hand,
    "hero"     => :hero,
    "pre"      => :preflop_action,
    "flop"     => :flop,
    "turn"     => :turn,
    "river"    => :river,
    "show"     => :showdown,
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

  NEW_HAND_OPTIONS = {
    'b' => :button,
    'p' => :players,
    'h' => :hero
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
   # cp = p
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

  action parseSeatingOptions {
    parse_seating_options(data[cp..p].pack('c*').strip)
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
  blinds       = (digit+.('/'.digit+)+)  %parseBlinds;
  big_blind    = 'bb' . space+ . digit+ >{cp = p} %parseBigBlind space_or_end; 
  small_blind  = 'sb' . space+ . digit+ >{cp = p} %parseSmallBlind space_or_end;
  ante         = ('a'|'ante').space+.digit+ >{cp = p} %parseAnte space_or_end;
  straddles    = 'straddle'.space+.digit+; # todo
  seating      = seat_pos . [bhp]{1,3} %parseSeatingOptions;
  seating_opts = seating . (space+ . seating)* ;

  nh_options = (seating_opts|blinds|big_blind|small_blind) (space+.(seating_opts|blinds|big_blind|small_blind))*; 

  new_hand   = ('n'|'nh'|'new'|'new hand') %{ set_cmd('nh'); cp = p };
  new_hand_t = ('nt'|'nht'|'new tourney')  %{ set_cmd('nt');  cp = p};
  hero       = ('h'|'hero')                %{ set_cmd('hero'); cp = p };
  preflop    = ('p'|'pre'|'preflop')       %{ set_cmd('pre'); cp = p };
  flop       = ('f'|'flop')                %{ set_cmd('flop'); cp = p };
  turn       = ('t'|'turn')                %{ set_cmd('turn'); cp = p };
  river      = ('r'|'river')               %{ set_cmd('river'); cp = p };
  showdown   = ('sh'|'show'|'showdown')    %{ set_cmd('show'); cp = p };

  status_request = (new_hand|new_hand_t|hero|preflop|flop|turn|river|showdown).zlen %{ set_status };

  cmd_nh    = (new_hand . space+) nh_options*;
  cmd_nht   = (new_hand_t . space+) nh_options*;
  cmd_hero  = (hero . space+) ;
  cmd_pre   = (preflop . space+);
  cmd_flop  = (flop . space+);
  cmd_turn  = (turn . space+);
  cmd_river = (river . space+);
  cmd_show  = (showdown . space+);

  commands = (cmd_nh|cmd_nht);

  main := |*
    commands;
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
    '.test status'         space >{cp = p} status_request;
  *|;

}%%

  def initialize(data)
    %% write data;
    data = data.unpack("c*") if data.is_a?(String)
    eof  = data.length
    cp   = 0

    @status     = false   # true if status request
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

  def set_cmd(key)
    @command = COMMANDS.fetch(key, nil)
  end

  def set_status
    @status = true
  end

  def parseCard(card)
    suit = card[-1..-1]
    val  = card[0..-2]
    @cards << "#{val.upcase}#{suit.downcase}"
  end

  def parseBlinds(data)
    p "parsing blinds for #{data}"
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

  def parse_seating_options(data)
    num = data.to_i 
    options = data.gsub(num.to_s,'')
    options.split('').each do |val|
      next unless key = NEW_HAND_OPTIONS.fetch(val,nil)
      @options[key] = num
    end
  end
    
end