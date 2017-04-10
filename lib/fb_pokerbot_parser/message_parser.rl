
class FbPokerbotParser::MessageParser

  attr_accessor :command, 
                :status,
                :options, 
                :players,
                :actions, 
                :cards, 
                :winners,

                :hole_cards,                 
                :flop, :turn, :river,
                :amount,
                :blinds,
                :hero

  VALID_SEATS = %w| utg utg1 utg2 utg3 lj hj co btn sb bb |

  COMMANDS = {
    "nh"       => :new_hand,
    "nt"       => :new_tourney_hand,
    "hero"     => :hero,
    "pre"      => :preflop,
    "flop"     => :flop,
    "turn"     => :turn,
    "river"    => :river,
    "show"     => :showdown,
    'w'        => :winner,
    'win'      => :winner,
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

  action parseSeatingOptions {
    parse_seating_options(data[cp..p].pack('c*').strip)
    cp = p
  }

  action set_stack_size {
    set_stack_size(data[cp..p].pack('c*').strip)
    cp = p
  }

  action set_hero_stack{
    set_hero_stack(data[cp..p].pack('c*').strip)
    cp = p
  }

  action parseSeatCards{
    parse_seat_cards(data[cp..p].pack('c*').strip)
    cp = p 
  }

  action setSeat {
    val = data[cp..(p-1)].pack('c*').strip
    set_curr_seat(val)
    cp = p
  }

  action setSeatCards {
    assign_cards_to_seat
  }

  action parseWinners {
    val = data[cp..(p-1)].pack('c*').strip
    set_winners(val)
  }

  space_or_end = space+ | zlen;

  # card definitions
  suit       = ('s'|'S'|'h'|'H'|'d'|'D'|'c'|'C'|'x'|'X'){1};
  cardval    = ('a'|'A'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'|'10'|'j'|'J'|'q'|'Q'|'k'|'K'|'x'|'X'){1};
  card       = (cardval.suit){1} %parseCard;
  cards      = (card space_or_end)+;
  hole_cards = (card space_or_end){2} %setHoleCards;
  flop_cards = (card space_or_end){3} %setFlop;

  # seat definitions
  seat       = 'utg'|'utg1'|'utg2'|'utg3'|'lj'|'hj'|'co'|'btn'|'sb'|'bb';
  seat_pos   = '1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'|'10';
  seat_cards = seat space+ %setSeat (card space_or_end){2} %setSeatCards;

  stack      = seat space+ digit+ %set_stack_size;
  hero_stack = digit+ %set_hero_stack;

  # action definitions
  bet_action   = ('b'|'bet') space+ digit+;
  call_action  = ('c'|'call');
  check_action = ('ch'|'check');
  fold_action  = ('f'|'fold');
  raise_action = ('r'|'raise') space+ digit+;
  muck_action  = ('m'|'muck');
  actions      = (bet_action|call_action|check_action|fold_action|muck_action|raise_action);
  dflt_action  = ('all'.space+)? (call_action|fold_action|check_action|muck_action)  %extractDefaultAction;
  seat_action  = (seat space+ actions %extractSeatAction) | dflt_action;
  seat_actions = seat_action (space+ seat_action)*;

  # nh options definitions
  # blinds 10/20/40/80  or 1000/2000/100 (tourney)
  # bb xxx sb xxx a|ante xx
  blinds       = digit+ ('/' digit+)+ %parseBlinds;
  big_blind    = 'bb' space+ digit+ >{cp = p} %parseBigBlind; 
  small_blind  = 'sb' space+ digit+ >{cp = p} %parseSmallBlind;
  ante         = ('a'|'ante') space+ digit+ >{cp = p} %parseAnte;
  straddles    = 'straddle' space+ digit+; # todo
  seating      = seat_pos . [bhp]{1,3} %parseSeatingOptions;
  seating_opts = seating . (space+ . seating)* ;

  nh_options = (blinds); 

  new_hand   = ('n'|'nh'|'new'|'new hand') %{ set_cmd('nh', p, pe); cp = p };
  new_hand_t = ('nt'|'nht'|'new tourney')  %{ set_cmd('nt', p, pe); cp = p};
  hero       = ('h'|'hero')                %{ set_cmd('hero', p, pe); cp = p };
  preflop    = ('p'|'pre'|'preflop')       %{ set_cmd('pre', p, pe); cp = p };
  flop       = ('f'|'flop')                %{ set_cmd('flop', p, pe); cp = p };
  turn       = ('t'|'turn')                %{ set_cmd('turn', p, pe); cp = p };
  river      = ('r'|'river')               %{ set_cmd('river', p, pe); cp = p };
  showdown   = ('sh'|'show'|'showdown')    %{ set_cmd('show', p, pe); cp = p };
  winner     = ('w'| 'win'|'winner')       %{ set_cmd('win', p, pe); cp = p };
  status_cmd = (new_hand|new_hand_t|hero|preflop|flop|turn|river|showdown);

  hand_opts = space+ (blinds|seating_opts|big_blind|small_blind|ante)
              (space+ (blinds|seating_opts|big_blind|small_blind|ante))? 
              (space+ (blinds|seating_opts|big_blind|small_blind|ante))? 
              (space+ (blinds|seating_opts|big_blind|small_blind|ante))?
              (space+ (blinds|seating_opts|big_blind|small_blind|ante))?;
  hero_opts = space+ (hole_cards|hero_stack)
              (space+ (hole_cards|hero_stack))?; 
  cmd_nh    = new_hand hand_opts;
  cmd_nht   = new_hand_t hand_opts;
  cmd_hero  = hero hero_opts;
  cmd_pre   = preflop space+ seat_actions;
  cmd_flop  = flop space+ (flop_cards|seat_actions) (space+ (flop_cards|seat_actions))?;
  cmd_turn  = turn space+ (card|seat_actions) (space+ (card|seat_actions))?;
  cmd_river = river space+ (card|seat_actions) (space+ (card|seat_actions))?;
  cmd_show  = showdown space+ seat_cards+;
  cmd_win   = winner space+ (seat|'hero') (space+ (seat|'hero'))* %parseWinners;

  commands = (cmd_nh|cmd_nht|cmd_hero|cmd_pre|cmd_flop|cmd_turn|cmd_river|cmd_show|cmd_win|status_cmd);

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
    '.test status'         space >{cp = p} status_cmd;
  *|;

}%%

  # message object:
  # 
  # msg.to_hash
  # {
  #   command: :new_hand,
  #   players: {
  #     btn : {
  #       cards: [],
  #       stack: 100
  #     },
  #     ...
  #     ...
  #     hero : {
  #       cards: [],
  #       stack: [],
  #       seat: x,

  #     }
  #   },
  #   options: {
  #     sb: 1,
  #     bb: 2,
  #     ante: nil,
  #     players: 9,
  #     btn: 5,
  #     hero: 2
  #   },
  #   cards: [],
  #   flop: [xx,xx,xx],
  #   turn: [xx],
  #   river: [xx],
  #   actions: {
  #     preflop: [
  #       seat: x, action: :bet, amount: 100,
  #       seat: 'all', action: :fold
  #     ],
  #     flop: [
  #       ...,
  #       ...
  #     ],
  #     turn: [],
  #     river: [],
  #     showdown: []
  #   },
  #   winners: []
  # }


  def initialize(data)
    %% write data;
    data = data.unpack("c*") if data.is_a?(String)
    eof  = data.length
    cp   = 0

    @status     = false   # true if status request
    @command    = ""
    @options    = {}
    @players    = {}
    @actions    = []
    @cards      = []
    @winners    = []

    @flop       = []
    @turn       = []
    @river      = []
    @hole_cards = []
    @hero       = {}
    @blinds     = {}
    @amount     = nil
    @_curr_seat = nil

    %% write init;
    %% write exec;
  end

  def set_cmd(key, p, pe)
    @command = COMMANDS.fetch(key, nil)
    set_status if pe == p
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
    sb, bb, *straddles = data.split("/")
    @blinds[:sb] = sb.to_i
    @blinds[:bb] = bb.to_i
    return if straddles.empty?
    if straddles.count == 1 && straddles.first.to_i < @blinds[:bb]
      @blinds[:ante] = straddles.first.to_i
    else
      @blinds[:straddle] = straddles.map(&:to_i)
    end
    @blinds
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
   
  def set_stack_size(data)
    seat, amount = data.split(" ")
    seat = seat.to_sym
    amount = amount.to_i
    @players[key] ||= {}
    @players[key][:stack] = amount
  end

  def set_hero_stack(data)
    @hero[:stack] = data.to_i
  end

  def set_curr_seat(data)
    @_curr_seat = data.to_sym if VALID_SEATS.include?(data)
  end

  def assign_cards_to_seat
    @players[@_curr_seat] ||= {}
    @players[@_curr_seat][:cards] = @cards.dup
    @cards = []
  end

  def set_winners(data)
    seats = data.split(" ")
    @winners = seats.select {|seat| VALID_SEATS.include?(seat) || seat == "hero" }
  end

  def to_hash
    {
      command: @command,
      status_command: @status,
      players: {},
      options: {},
      actions: {},
      cards: {
        flop: [],
        turn: [],
        river: [],
        hero: [],
        # <:seat> : []
      },
      winners: []
    }
  end

  # players = {
  #   btn: {
  #     seat: 1-9,
  #     stack: 1000,
  #     cards: [],
  #     name: ''
  #   },
  #   co: {
  #     seat: 1-9,
  #     stack: 1000,
  #     cards: [],
  #     name: ''
  #   }
  # }


end