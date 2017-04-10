
class FbPokerbotParser::MessageParser

  attr_accessor :command, 
                :status_only,
                :options, 
                :players,
                :actions, 
                :cards, 
                :winners

  attr_reader :_cards, :_curr_seat


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
    parse_card(data[cp..(p-1)].pack('c*').strip)    
    cp = p
  }
  action setFlop {
    set_flop
  }

  action setHoleCards {
    set_hole_cards
  }

  action parseBlinds {
    val = data[cp..(p-1)].pack('c*').strip
    parse_blinds(val)
    cp = p
  }

  action parseBigBlind {
    val = data[cp..(p-1)].pack('c*').strip
    parse_big_blind(val)
    cp = p
  }

  action parseSmallBlind {
    val = data[cp..(p-1)].pack('c*').strip
    parse_small_blind(val)
    cp = p
  }

  action parseAnte {
    val = data[cp..(p-1)].pack('c*').strip
    parse_ante(val)
    cp = p
  }
  
  action extractSeatAction {
    val = data[cp..p].pack('c*').strip
    extract_seat_action(val)
    cp = p
  }

  action extractDefaultAction {
    val = data[cp..p].pack('c*').strip
    extract_default_action(val)
    cp = p
  }

  action parseSeatingOptions {
    val = data[cp..p].pack('c*').strip
    parse_seating_options(val)
    cp = p
  }

  action set_stack_size {
    val = data[cp..p].pack('c*').strip
    set_stack_size(val)
    cp = p
  }

  action set_hero_stack{
    val = data[cp..p].pack('c*').strip    
    set_stack(:hero, val)
    cp = p
  }

  action parseSeatCards{
    val = data[cp..p].pack('c*').strip
    parse_seat_cards(val)
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
  cmd_turn  = turn space+ (card|seat_actions) (space+ (card|seat_actions))? %{ assign_cards(:turn) };
  cmd_river = river space+ (card|seat_actions) (space+ (card|seat_actions))? %{ assign_cards(:river) };
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

    @status_only = false   # true if status_only request
    @command     = ""
    @options     = {
      blinds: {}
    }
    @players     = {}
    @actions     = []
    @cards       = {}
    @winners     = []

    # temp vars
    @_curr_seat = nil
    @_cards     = []

    %% write init;
    %% write exec;
  end

  def set_cmd(key, p, pe)
    @command = COMMANDS.fetch(key, nil)
    set_status_only if pe == p
  end

  def set_status_only
    @status_only = true
  end


  def parse_card(card)
    suit = card[-1..-1]
    val  = card[0..-2]
    @_cards << "#{val.upcase}#{suit.downcase}"
  end

  def set_flop
    return unless @_cards.count == 3
    assign_cards(:flop)
  end

  def set_hole_cards
    return unless @_cards.count == 2
    assign_cards(:hero)
  end

  def assign_cards(key)
    @cards[key] = @_cards.dup
    @_cards = []
  end


  def parse_blinds(data)
    sb, bb, *straddles = data.split("/")
    @options[:blinds][:sb] = sb.to_i
    @options[:blinds][:bb] = bb.to_i
    return if straddles.empty?
    if straddles.count == 1 && straddles.first.to_i < @options[:blinds].fetch(:bb, 0)
      @options[:blinds][:ante] = straddles.first.to_i
    else
      @options[:blinds][:straddle] = straddles.map(&:to_i)
    end
    @options[:blinds]
  end

  def parse_big_blind(data)
    @options[:blinds][:bb] = data.to_i
    @options[:blinds][:sb] = (@options[:blinds][:bb] / 2) if @options[:blinds][:sb].nil?
  end

  def parse_small_blind(data)
    @options[:blinds][:sb] = data.to_i
  end

  def parse_ante(data)
    @options[:blinds][:ante] = data.to_i
  end

  def extract_seat_action(data)
    seat, action, amount = data.split(' ')
    amount = amount.to_i unless amount.nil?
    @actions << {seat: seat, action: ACTIONS.fetch(action,nil), amount: amount}
  end

  def extract_default_action(data)
    action = data.split(" ").last
    @actions << {seat: 'all', action: ACTIONS.fetch(action,nil), amount: nil}
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
    set_stack(seat, amount)
  end

  def set_stack(seat, amount)
    @players[seat] ||= {}
    @players[seat][:stack] = amount.to_i
  end

  def set_curr_seat(data)
    @_curr_seat = data.to_sym if VALID_SEATS.include?(data)
  end

  def assign_cards_to_seat
    @players[@_curr_seat] ||= {}
    @players[@_curr_seat][:cards] = @_cards.dup
    @_cards = []
  end

  def set_winners(data)
    seats = data.split(" ")
    @winners = seats.select {|seat| VALID_SEATS.include?(seat) || seat == "hero" }
  end

  def to_hash
    {
      command: @command,
      status_only: @status_only,
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