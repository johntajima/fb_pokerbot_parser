
# line 1 "./lib/fb_pokerbot_parser/message_parser.rl"
=begin

# line 27 "./lib/fb_pokerbot_parser/message_parser.rl"

=end 

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



  def initialize(data)
    
# line 47 "./lib/fb_pokerbot_parser/message_parser.rb"
class << self
	attr_accessor :_pokerbot_actions
	private :_pokerbot_actions, :_pokerbot_actions=
end
self._pokerbot_actions = [
	0, 1, 0, 1, 2, 1, 5, 1, 
	9, 2, 1, 8, 2, 3, 4, 2, 
	6, 7, 3, 0, 1, 8, 3, 6, 
	0, 7
]

class << self
	attr_accessor :_pokerbot_key_offsets
	private :_pokerbot_key_offsets, :_pokerbot_key_offsets=
end
self._pokerbot_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 6, 
	7, 8, 9, 10, 13, 24, 25, 33, 
	34, 48
]

class << self
	attr_accessor :_pokerbot_trans_keys
	private :_pokerbot_trans_keys, :_pokerbot_trans_keys=
end
self._pokerbot_trans_keys = [
	116, 101, 115, 116, 45, 99, 97, 114, 
	100, 115, 32, 9, 13, 49, 65, 81, 
	97, 113, 50, 57, 74, 75, 106, 107, 
	48, 72, 83, 104, 115, 67, 68, 99, 
	100, 46, 32, 49, 65, 81, 97, 113, 
	9, 13, 50, 57, 74, 75, 106, 107, 
	49, 65, 81, 97, 113, 50, 57, 74, 
	75, 106, 107, 0
]

class << self
	attr_accessor :_pokerbot_single_lengths
	private :_pokerbot_single_lengths, :_pokerbot_single_lengths=
end
self._pokerbot_single_lengths = [
	0, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 5, 1, 4, 1, 
	6, 5
]

class << self
	attr_accessor :_pokerbot_range_lengths
	private :_pokerbot_range_lengths, :_pokerbot_range_lengths=
end
self._pokerbot_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 1, 3, 0, 2, 0, 
	4, 3
]

class << self
	attr_accessor :_pokerbot_index_offsets
	private :_pokerbot_index_offsets, :_pokerbot_index_offsets=
end
self._pokerbot_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	14, 16, 18, 20, 23, 32, 34, 41, 
	43, 54
]

class << self
	attr_accessor :_pokerbot_indicies
	private :_pokerbot_indicies, :_pokerbot_indicies=
end
self._pokerbot_indicies = [
	0, 1, 2, 1, 3, 1, 4, 1, 
	5, 1, 6, 1, 7, 1, 8, 1, 
	9, 1, 10, 1, 11, 11, 1, 12, 
	13, 13, 13, 13, 13, 13, 13, 1, 
	13, 14, 15, 15, 15, 15, 15, 15, 
	14, 16, 1, 18, 19, 20, 20, 20, 
	20, 18, 20, 20, 20, 17, 12, 13, 
	13, 13, 13, 13, 13, 13, 21, 0
]

class << self
	attr_accessor :_pokerbot_trans_targs
	private :_pokerbot_trans_targs, :_pokerbot_trans_targs=
end
self._pokerbot_trans_targs = [
	2, 0, 3, 4, 5, 6, 7, 8, 
	9, 10, 11, 12, 13, 14, 15, 16, 
	1, 15, 17, 13, 14, 15
]

class << self
	attr_accessor :_pokerbot_trans_actions
	private :_pokerbot_trans_actions, :_pokerbot_trans_actions=
end
self._pokerbot_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 3, 0, 0, 7, 15, 
	0, 18, 22, 1, 1, 9
]

class << self
	attr_accessor :_pokerbot_to_state_actions
	private :_pokerbot_to_state_actions, :_pokerbot_to_state_actions=
end
self._pokerbot_to_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 12, 
	0, 0
]

class << self
	attr_accessor :_pokerbot_from_state_actions
	private :_pokerbot_from_state_actions, :_pokerbot_from_state_actions=
end
self._pokerbot_from_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 5, 
	0, 0
]

class << self
	attr_accessor :_pokerbot_eof_trans
	private :_pokerbot_eof_trans, :_pokerbot_eof_trans=
end
self._pokerbot_eof_trans = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 15, 15, 0, 
	18, 22
]

class << self
	attr_accessor :pokerbot_start
end
self.pokerbot_start = 15;
class << self
	attr_accessor :pokerbot_first_final
end
self.pokerbot_first_final = 15;
class << self
	attr_accessor :pokerbot_error
end
self.pokerbot_error = 0;

class << self
	attr_accessor :pokerbot_en_main
end
self.pokerbot_en_main = 15;


# line 67 "./lib/fb_pokerbot_parser/message_parser.rl"

    data = data.unpack("c*") if data.is_a?(String)
    eof  = data.length
    cp   = 0

    @cards   = []
    @options = {}
    @command = ""

    
# line 209 "./lib/fb_pokerbot_parser/message_parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = pokerbot_start
	ts = nil
	te = nil
	act = 0
end

# line 77 "./lib/fb_pokerbot_parser/message_parser.rl"
    
# line 221 "./lib/fb_pokerbot_parser/message_parser.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_acts = _pokerbot_from_state_actions[cs]
	_nacts = _pokerbot_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _pokerbot_actions[_acts - 1]
			when 5 then
# line 1 "NONE"
		begin
ts = p
		end
# line 255 "./lib/fb_pokerbot_parser/message_parser.rb"
		end # from state action switch
	end
	if _trigger_goto
		next
	end
	_keys = _pokerbot_key_offsets[cs]
	_trans = _pokerbot_index_offsets[cs]
	_klen = _pokerbot_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _pokerbot_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _pokerbot_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _pokerbot_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _pokerbot_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _pokerbot_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _pokerbot_indicies[_trans]
	end
	if _goto_level <= _eof_trans
	cs = _pokerbot_trans_targs[_trans]
	if _pokerbot_trans_actions[_trans] != 0
		_acts = _pokerbot_trans_actions[_trans]
		_nacts = _pokerbot_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _pokerbot_actions[_acts - 1]
when 0 then
# line 5 "./lib/fb_pokerbot_parser/message_parser.rl"
		begin

    card = data[cp..(p-1)].pack('c*').strip
    suit = card[-1..-1]
    val  = card.gsub(suit,'')
    @cards << "#{val.upcase}#{suit.downcase}"
    cp = p
  		end
when 1 then
# line 13 "./lib/fb_pokerbot_parser/message_parser.rl"
		begin

    nil
  		end
when 2 then
# line 24 "./lib/fb_pokerbot_parser/message_parser.rl"
		begin
 cp = p 		end
when 6 then
# line 1 "NONE"
		begin
te = p+1
		end
when 7 then
# line 24 "./lib/fb_pokerbot_parser/message_parser.rl"
		begin
act = 1;		end
when 8 then
# line 24 "./lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 9 then
# line 1 "NONE"
		begin
	case act
	when 0 then
	begin	begin
		cs = 0
		_trigger_goto = true
		_goto_level = _again
		break
	end
end
	else
	begin begin p = ((te))-1; end
end
end 
			end
# line 373 "./lib/fb_pokerbot_parser/message_parser.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	_acts = _pokerbot_to_state_actions[cs]
	_nacts = _pokerbot_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _pokerbot_actions[_acts - 1]
when 3 then
# line 1 "NONE"
		begin
ts = nil;		end
when 4 then
# line 1 "NONE"
		begin
act = 0
		end
# line 398 "./lib/fb_pokerbot_parser/message_parser.rb"
		end # to state action switch
	end
	if _trigger_goto
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	if _pokerbot_eof_trans[cs] > 0
		_trans = _pokerbot_eof_trans[cs] - 1;
		_goto_level = _eof_trans
		next;
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 78 "./lib/fb_pokerbot_parser/message_parser.rl"
  end
    
end