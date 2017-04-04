class FbPokerbotParser::MessageParser

  attr_accessor :command
  attr_accessor :options
  attr_accessor :cards
  
  COMMANDS = {
    "n"        => :new_hand,
    "nh"       => :new_hand,
    "new"      => :new_hand,
    "nt"       => :new_tourney_hand,
    "nht"      => :new_tourney_hand,
    "h"        => :hero,
    "hero"     => :hero,
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
    "s"        => :showdown,
    "showdown" => :showdown,
    "c"        => :config,
    "config"   => :config,
    "set"      => :config 
  }


=begin
%%{
  machine pokerbot;

  action parseCard {
    card = data[cp..(p-1)].pack('c*').strip
    suit = card[-1..-1]
    val  = card.gsub(suit,'')
    @cards << "#{val.upcase}#{suit.downcase}"
    cp = p
  }

  action extractCommand {
    value = data[cp..(p-1)].pack('c*').strip
    puts "extractCommand #{value}"
    @command = COMMANDS.fetch(value,nil)    
    cp = p
  }

  suit     = ('s'|'S'|'h'|'H'|'d'|'D'|'c'|'C');
  cardval  = ('a'|'A'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'|'10'|'j'|'J'|'q'|'Q'|'k'|'K');
  card     = (cardval suit) %parseCard;
  cards    = (card space?)+;

  utg          = 'utg';
  utg1         = 'utg1';
  utg2         = 'utg2';
  utg3         = 'utg3';
  lj           = 'lj';
  hj           = 'hj';
  co           = 'co';
  btn          = 'btn';
  sb           = 'sb';
  bb           = 'bb';
  position     = (utg|utg1|utg2|utg3|lj|hj|co|btn|sb|bb);
  seat         = ('1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'|'10');

  ante         = 'a'. digit+;
  big_blind    = bb . digit+;
  small_blind  = sb . digit+;

  bet_action   = ('b' | 'bet');
  call_action  = ('c' | 'call');
  check_action = ('c' | 'check');
  fold_action  = ('f' | 'fold');
  raise_action = ('r' | 'raise');
  muck_action  = ('m' | 'muck');

  cmd_nh    = 'n'|'nh'|'new';
  cmd_nth   = 'nt'|'nht';
  cmd_hero  = 'h'|'hero';
  cmd_pre   = 'p'|'pre'|'preflop';
  cmd_flop  = 'f'|'flop';
  cmd_fa    = 'fa';
  cmd_turn  = 't'|'turn';
  cmd_ta    = 'ta';
  cmd_river = 'r'|'river';
  cmd_ra    = 'ra';
  cmd_show  = 's'|'show'|'showdown';
  cmd_edit  = 'e'|'edit';
  cmd_set   = 'c'|'config'|'set';
  
  nh_options = any+;

  new_hand  = cmd_nh space >extractCommand nh_options;


  commands     = cmd_newhand | 
                 cmd_newtourneyhand | 
                 cmd_hero | 
                 cmd_preflop_action |
                 cmd_flop | 
                 cmd_flop_action | 
                 cmd_turn | 
                 cmd_turn_action | 
                 cmd_river |
                 cmd_river_action |
                 cmd_showdown |
                 cmd_edit |
                 cmd_set; 

  main := |*
    new_hand;
    '.test-cards' space >{ cp = p } cards;
  *|;

}%%
=end 


  def initialize(data)
    %% write data;

    data = data.unpack("c*") if data.is_a?(String)
    eof  = data.length
    cp   = 0

    @cards   = []
    @options = {}
    @command = ""

    %% write init;
    %% write exec;
  end
    
end