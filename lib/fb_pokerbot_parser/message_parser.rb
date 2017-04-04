
# line 1 "lib/fb_pokerbot_parser/message_parser.rl"

class FbPokerbotParser::MessageParser

  attr_accessor :command, :options, :cards, :actions, :flop, :hole_cards, :amount


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



# line 167 "lib/fb_pokerbot_parser/message_parser.rl"

# %



  def initialize(data)
    
# line 63 "lib/fb_pokerbot_parser/message_parser.rb"
class << self
	attr_accessor :_pokerbot_actions
	private :_pokerbot_actions, :_pokerbot_actions=
end
self._pokerbot_actions = [
	0, 1, 0, 1, 3, 1, 4, 1, 
	6, 1, 7, 1, 8, 1, 9, 1, 
	12, 1, 13, 1, 16, 1, 17, 1, 
	18, 1, 20, 1, 22, 1, 23, 1, 
	24, 2, 0, 18, 2, 1, 19, 2, 
	2, 21, 2, 3, 20, 2, 4, 20, 
	2, 10, 11, 2, 13, 3, 2, 13, 
	4, 2, 13, 5, 2, 13, 14, 2, 
	13, 15, 3, 0, 1, 19, 3, 13, 
	0, 14, 3, 13, 3, 15, 3, 13, 
	4, 15
]

class << self
	attr_accessor :_pokerbot_key_offsets
	private :_pokerbot_key_offsets, :_pokerbot_key_offsets=
end
self._pokerbot_key_offsets = [
	0, 0, 1, 2, 3, 4, 6, 7, 
	8, 9, 10, 11, 12, 15, 17, 20, 
	21, 22, 23, 24, 25, 28, 37, 38, 
	39, 42, 43, 49, 51, 54, 59, 63, 
	65, 66, 67, 73, 74, 75, 76, 77, 
	78, 79, 80, 81, 82, 83, 88, 89, 
	92, 93, 94, 95, 96, 97, 98, 102, 
	103, 104, 105, 106, 107, 109, 112, 117, 
	121, 123, 124, 127, 128, 129, 130, 131, 
	132, 133, 137, 138, 139, 140, 141, 142, 
	143, 144, 145, 150, 151, 152, 153, 154, 
	157, 168, 169, 177, 178, 179, 180, 181, 
	182, 183, 184, 185, 186, 189, 200, 201, 
	209, 223, 234, 235, 243, 257, 268, 269, 
	277, 278, 280, 282, 289, 298, 306, 313, 
	321, 328, 336, 344, 351, 359, 367, 374, 
	382, 389, 397, 405, 407, 409, 409, 410, 
	411, 412, 421, 435, 446, 449, 449
]

class << self
	attr_accessor :_pokerbot_trans_keys
	private :_pokerbot_trans_keys, :_pokerbot_trans_keys=
end
self._pokerbot_trans_keys = [
	116, 101, 115, 116, 32, 45, 97, 109, 
	111, 117, 110, 116, 32, 9, 13, 48, 
	57, 97, 99, 102, 99, 116, 105, 111, 
	110, 32, 9, 13, 97, 98, 99, 102, 
	104, 108, 109, 115, 117, 108, 108, 32, 
	9, 13, 99, 98, 99, 104, 108, 115, 
	117, 98, 116, 32, 9, 13, 98, 99, 
	102, 109, 114, 32, 101, 9, 13, 48, 
	57, 108, 108, 98, 99, 104, 108, 115, 
	117, 108, 108, 99, 107, 108, 100, 106, 
	98, 116, 103, 32, 9, 13, 49, 51, 
	116, 32, 9, 13, 108, 108, 99, 107, 
	108, 100, 32, 97, 9, 13, 105, 115, 
	101, 110, 111, 98, 116, 32, 9, 13, 
	98, 99, 102, 109, 114, 32, 101, 9, 
	13, 48, 57, 116, 32, 9, 13, 108, 
	108, 99, 107, 108, 100, 32, 97, 9, 
	13, 105, 115, 101, 110, 106, 98, 116, 
	103, 32, 9, 13, 49, 51, 97, 114, 
	100, 115, 32, 9, 13, 49, 65, 81, 
	97, 113, 50, 57, 74, 75, 106, 107, 
	48, 72, 83, 104, 115, 67, 68, 99, 
	100, 108, 111, 112, 45, 99, 97, 114, 
	100, 115, 32, 9, 13, 49, 65, 81, 
	97, 113, 50, 57, 74, 75, 106, 107, 
	48, 72, 83, 104, 115, 67, 68, 99, 
	100, 32, 49, 65, 81, 97, 113, 9, 
	13, 50, 57, 74, 75, 106, 107, 49, 
	65, 81, 97, 113, 50, 57, 74, 75, 
	106, 107, 48, 72, 83, 104, 115, 67, 
	68, 99, 100, 32, 49, 65, 81, 97, 
	113, 9, 13, 50, 57, 74, 75, 106, 
	107, 49, 65, 81, 97, 113, 50, 57, 
	74, 75, 106, 107, 48, 72, 83, 104, 
	115, 67, 68, 99, 100, 119, 46, 110, 
	48, 57, 32, 97, 99, 102, 109, 9, 
	13, 32, 97, 99, 102, 109, 9, 13, 
	48, 57, 32, 97, 99, 102, 104, 109, 
	9, 13, 32, 97, 99, 102, 109, 9, 
	13, 32, 97, 99, 102, 109, 111, 9, 
	13, 32, 97, 99, 102, 109, 9, 13, 
	32, 97, 99, 102, 109, 111, 9, 13, 
	32, 97, 99, 102, 109, 117, 9, 13, 
	32, 97, 99, 102, 109, 9, 13, 32, 
	97, 99, 101, 102, 109, 9, 13, 32, 
	97, 99, 102, 104, 109, 9, 13, 32, 
	97, 99, 102, 109, 9, 13, 32, 97, 
	99, 101, 102, 109, 9, 13, 32, 97, 
	99, 102, 109, 9, 13, 32, 97, 99, 
	102, 109, 111, 9, 13, 32, 97, 99, 
	102, 109, 117, 9, 13, 48, 57, 97, 
	104, 101, 111, 117, 32, 97, 99, 102, 
	104, 109, 111, 9, 13, 32, 49, 65, 
	81, 97, 113, 9, 13, 50, 57, 74, 
	75, 106, 107, 49, 65, 81, 97, 113, 
	50, 57, 74, 75, 106, 107, 32, 9, 
	13, 101, 104, 0
]

class << self
	attr_accessor :_pokerbot_single_lengths
	private :_pokerbot_single_lengths, :_pokerbot_single_lengths=
end
self._pokerbot_single_lengths = [
	0, 1, 1, 1, 1, 2, 1, 1, 
	1, 1, 1, 1, 1, 0, 3, 1, 
	1, 1, 1, 1, 1, 9, 1, 1, 
	1, 1, 6, 2, 1, 5, 2, 0, 
	1, 1, 6, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 2, 1, 
	1, 1, 1, 1, 2, 1, 5, 2, 
	0, 1, 1, 1, 1, 1, 1, 1, 
	1, 2, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	5, 1, 4, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 5, 1, 4, 
	6, 5, 1, 4, 6, 5, 1, 4, 
	1, 2, 0, 5, 5, 6, 5, 6, 
	5, 6, 6, 5, 6, 6, 5, 6, 
	5, 6, 6, 0, 2, 0, 1, 1, 
	1, 7, 6, 5, 1, 0, 2
]

class << self
	attr_accessor :_pokerbot_range_lengths
	private :_pokerbot_range_lengths, :_pokerbot_range_lengths=
end
self._pokerbot_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 1, 0, 0, 
	0, 0, 0, 0, 1, 0, 0, 0, 
	1, 0, 0, 0, 1, 0, 1, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 2, 0, 1, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 1, 0, 1, 
	1, 0, 1, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 2, 0, 0, 0, 0, 1, 
	3, 0, 2, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 3, 0, 2, 
	4, 3, 0, 2, 4, 3, 0, 2, 
	0, 0, 1, 1, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 0, 0, 0, 0, 
	0, 1, 4, 3, 1, 0, 0
]

class << self
	attr_accessor :_pokerbot_index_offsets
	private :_pokerbot_index_offsets, :_pokerbot_index_offsets=
end
self._pokerbot_index_offsets = [
	0, 0, 2, 4, 6, 8, 11, 13, 
	15, 17, 19, 21, 23, 26, 28, 32, 
	34, 36, 38, 40, 42, 45, 55, 57, 
	59, 62, 64, 71, 74, 77, 83, 87, 
	89, 91, 93, 100, 102, 104, 106, 108, 
	110, 112, 114, 116, 118, 120, 124, 126, 
	129, 131, 133, 135, 137, 139, 141, 145, 
	147, 149, 151, 153, 155, 158, 161, 167, 
	171, 173, 175, 178, 180, 182, 184, 186, 
	188, 190, 194, 196, 198, 200, 202, 204, 
	206, 208, 210, 214, 216, 218, 220, 222, 
	225, 234, 236, 243, 245, 247, 249, 251, 
	253, 255, 257, 259, 261, 264, 273, 275, 
	282, 293, 302, 304, 311, 322, 331, 333, 
	340, 342, 345, 347, 354, 362, 370, 377, 
	385, 392, 400, 408, 415, 423, 431, 438, 
	446, 453, 461, 469, 471, 474, 475, 477, 
	479, 481, 490, 501, 510, 513, 514
]

class << self
	attr_accessor :_pokerbot_trans_targs
	private :_pokerbot_trans_targs, :_pokerbot_trans_targs=
end
self._pokerbot_trans_targs = [
	2, 0, 3, 0, 4, 0, 5, 0, 
	6, 14, 0, 7, 0, 8, 0, 9, 
	0, 10, 0, 11, 0, 12, 0, 13, 
	13, 0, 114, 0, 15, 83, 91, 0, 
	16, 0, 17, 0, 18, 0, 19, 0, 
	20, 0, 21, 21, 0, 22, 60, 137, 
	121, 78, 78, 122, 79, 80, 0, 23, 
	113, 24, 113, 25, 25, 113, 115, 113, 
	27, 59, 41, 41, 42, 43, 113, 28, 
	58, 113, 29, 29, 113, 30, 125, 129, 
	130, 54, 113, 31, 46, 31, 113, 116, 
	113, 33, 113, 118, 113, 27, 119, 41, 
	41, 42, 43, 113, 36, 113, 120, 113, 
	38, 113, 123, 113, 40, 113, 123, 113, 
	28, 113, 28, 113, 44, 113, 45, 113, 
	29, 29, 28, 113, 47, 113, 31, 31, 
	113, 49, 113, 126, 113, 51, 113, 128, 
	113, 53, 113, 128, 113, 31, 55, 31, 
	113, 56, 113, 57, 113, 47, 113, 28, 
	113, 28, 113, 61, 77, 0, 62, 62, 
	113, 63, 132, 135, 136, 73, 113, 64, 
	65, 64, 113, 131, 113, 66, 113, 64, 
	64, 113, 68, 113, 133, 113, 70, 113, 
	133, 113, 72, 113, 133, 113, 64, 74, 
	64, 113, 75, 113, 76, 113, 66, 113, 
	61, 0, 61, 0, 61, 0, 81, 0, 
	82, 0, 62, 62, 61, 0, 84, 0, 
	85, 0, 86, 0, 87, 0, 88, 88, 
	0, 89, 90, 90, 90, 90, 90, 90, 
	90, 0, 90, 113, 138, 138, 138, 138, 
	138, 138, 113, 92, 0, 93, 0, 94, 
	0, 95, 0, 96, 0, 97, 0, 98, 
	0, 99, 0, 100, 0, 101, 101, 0, 
	102, 103, 103, 103, 103, 103, 103, 103, 
	0, 103, 0, 104, 104, 104, 104, 104, 
	104, 0, 105, 106, 107, 107, 107, 107, 
	105, 107, 107, 107, 0, 106, 107, 107, 
	107, 107, 107, 107, 107, 0, 107, 0, 
	108, 108, 108, 108, 108, 108, 0, 109, 
	110, 111, 111, 111, 111, 109, 111, 111, 
	111, 0, 110, 111, 111, 111, 111, 111, 
	111, 111, 0, 111, 0, 140, 140, 140, 
	140, 140, 140, 0, 113, 113, 1, 142, 
	0, 114, 113, 26, 35, 117, 121, 122, 
	26, 113, 26, 22, 117, 121, 122, 26, 
	116, 113, 26, 32, 117, 121, 124, 122, 
	26, 113, 34, 22, 117, 121, 122, 34, 
	113, 26, 35, 117, 121, 122, 28, 26, 
	113, 34, 22, 117, 121, 122, 34, 113, 
	26, 22, 117, 121, 122, 39, 26, 113, 
	26, 22, 117, 121, 122, 37, 26, 113, 
	26, 22, 117, 121, 122, 26, 113, 26, 
	22, 117, 37, 121, 122, 26, 113, 26, 
	48, 117, 121, 127, 122, 26, 113, 34, 
	22, 117, 121, 122, 34, 113, 26, 22, 
	117, 50, 121, 122, 26, 113, 26, 22, 
	117, 121, 122, 26, 113, 26, 22, 117, 
	121, 122, 52, 26, 113, 26, 22, 117, 
	121, 122, 50, 26, 113, 131, 113, 67, 
	134, 113, 113, 69, 113, 71, 113, 69, 
	113, 26, 32, 117, 121, 124, 122, 61, 
	26, 113, 139, 89, 90, 90, 90, 90, 
	139, 90, 90, 90, 113, 89, 90, 90, 
	90, 90, 90, 90, 90, 113, 141, 141, 
	113, 113, 112, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 113, 113, 113, 113, 113, 
	113, 113, 113, 0
]

class << self
	attr_accessor :_pokerbot_trans_actions
	private :_pokerbot_trans_actions, :_pokerbot_trans_actions=
end
self._pokerbot_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 13, 
	13, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 11, 11, 0, 0, 0, 63, 
	63, 0, 0, 63, 0, 0, 0, 0, 
	31, 0, 31, 0, 0, 31, 17, 31, 
	0, 0, 0, 0, 0, 0, 29, 0, 
	0, 29, 0, 0, 29, 0, 17, 63, 
	63, 0, 29, 0, 0, 0, 29, 63, 
	29, 0, 29, 63, 29, 0, 17, 0, 
	0, 0, 0, 29, 0, 29, 63, 29, 
	0, 29, 63, 29, 0, 29, 63, 29, 
	0, 29, 0, 29, 0, 29, 0, 29, 
	0, 0, 0, 29, 0, 29, 0, 0, 
	29, 0, 29, 63, 29, 0, 29, 63, 
	29, 0, 29, 63, 29, 0, 0, 0, 
	29, 0, 29, 0, 29, 0, 29, 0, 
	29, 0, 29, 0, 0, 0, 0, 0, 
	31, 0, 17, 17, 17, 0, 31, 0, 
	0, 0, 31, 0, 31, 0, 31, 0, 
	0, 31, 0, 29, 0, 29, 0, 29, 
	0, 29, 0, 29, 0, 29, 0, 0, 
	0, 31, 0, 31, 0, 31, 0, 31, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 7, 7, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 31, 60, 60, 60, 60, 
	60, 60, 31, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 9, 9, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 19, 27, 0, 57, 
	0, 0, 39, 0, 0, 17, 63, 63, 
	0, 25, 3, 3, 51, 74, 74, 3, 
	63, 42, 5, 5, 54, 78, 63, 78, 
	5, 45, 5, 5, 54, 78, 78, 5, 
	45, 0, 0, 17, 63, 63, 0, 0, 
	25, 0, 0, 17, 63, 63, 0, 25, 
	5, 5, 54, 78, 78, 0, 5, 45, 
	5, 5, 54, 78, 78, 0, 5, 45, 
	5, 5, 54, 78, 78, 5, 45, 5, 
	5, 54, 0, 78, 78, 5, 45, 3, 
	3, 51, 74, 63, 74, 3, 42, 3, 
	3, 51, 74, 74, 3, 42, 3, 3, 
	51, 0, 74, 74, 3, 42, 3, 3, 
	51, 74, 74, 3, 42, 3, 3, 51, 
	74, 74, 0, 3, 42, 3, 3, 51, 
	74, 74, 0, 3, 42, 0, 42, 0, 
	17, 42, 42, 0, 42, 0, 42, 0, 
	42, 5, 5, 54, 78, 63, 78, 0, 
	5, 45, 70, 1, 1, 1, 1, 1, 
	70, 1, 1, 1, 33, 0, 0, 0, 
	0, 0, 0, 0, 0, 23, 1, 1, 
	66, 36, 0, 19, 21, 31, 31, 31, 
	31, 29, 29, 29, 29, 29, 29, 29, 
	29, 29, 29, 29, 29, 29, 29, 29, 
	29, 29, 29, 29, 29, 29, 29, 29, 
	29, 29, 29, 29, 29, 29, 29, 29, 
	29, 29, 29, 31, 31, 31, 31, 31, 
	31, 29, 29, 29, 29, 29, 29, 31, 
	31, 31, 31, 31, 31, 27, 39, 25, 
	42, 45, 45, 25, 25, 45, 45, 45, 
	45, 42, 42, 42, 42, 42, 42, 42, 
	42, 42, 42, 42, 42, 45, 33, 23, 
	66, 36, 21, 0
]

class << self
	attr_accessor :_pokerbot_to_state_actions
	private :_pokerbot_to_state_actions, :_pokerbot_to_state_actions=
end
self._pokerbot_to_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 48, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0
]

class << self
	attr_accessor :_pokerbot_from_state_actions
	private :_pokerbot_from_state_actions, :_pokerbot_from_state_actions=
end
self._pokerbot_from_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 15, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0
]

class << self
	attr_accessor :_pokerbot_eof_trans
	private :_pokerbot_eof_trans, :_pokerbot_eof_trans=
end
self._pokerbot_eof_trans = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 573, 573, 
	573, 573, 567, 567, 567, 567, 567, 567, 
	567, 567, 567, 567, 567, 567, 567, 567, 
	567, 567, 567, 567, 567, 567, 567, 567, 
	567, 567, 567, 567, 567, 567, 567, 567, 
	567, 567, 567, 567, 0, 573, 573, 573, 
	573, 573, 573, 567, 567, 567, 567, 567, 
	567, 573, 573, 573, 573, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 573, 573, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	574, 0, 575, 581, 597, 598, 598, 581, 
	581, 598, 598, 598, 598, 597, 597, 597, 
	597, 597, 597, 597, 597, 597, 597, 597, 
	597, 598, 599, 600, 601, 602, 603
]

class << self
	attr_accessor :pokerbot_start
end
self.pokerbot_start = 113;
class << self
	attr_accessor :pokerbot_first_final
end
self.pokerbot_first_final = 113;
class << self
	attr_accessor :pokerbot_error
end
self.pokerbot_error = 0;

class << self
	attr_accessor :pokerbot_en_main
end
self.pokerbot_en_main = 113;


# line 174 "lib/fb_pokerbot_parser/message_parser.rl"

    data = data.unpack("c*") if data.is_a?(String)
    eof  = data.length
    cp   = 0

    @cards   = []
    @options = {}
    @actions = []
    @command = ""
    @flop    = []
    @turn    = []
    @river   = [] 
    @hole_cards = []
    @amount = nil

    
# line 523 "lib/fb_pokerbot_parser/message_parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = pokerbot_start
	ts = nil
	te = nil
	act = 0
end

# line 190 "lib/fb_pokerbot_parser/message_parser.rl"
    
# line 535 "lib/fb_pokerbot_parser/message_parser.rb"
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
			when 12 then
# line 1 "NONE"
		begin
ts = p
		end
# line 569 "lib/fb_pokerbot_parser/message_parser.rb"
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
# line 54 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    card = data[cp..(p-1)].pack('c*').strip
    suit = card[-1..-1]
    val  = card[0..-2]
    @cards << "#{val.upcase}#{suit.downcase}"
    cp = p
  		end
when 1 then
# line 61 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    @flop = @cards if @cards.count == 3
  		end
when 2 then
# line 68 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..(p-1)].pack('c*').strip
    @amount = value.to_i
    cp = p
  		end
when 3 then
# line 78 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..p].pack('c*').strip
    seat, action, amount = value.split(' ')
    amount = amount.to_i unless amount.nil?
    @actions << {seat: seat, action: ACTIONS.fetch(action,nil), amount: amount}
    cp = p
  		end
when 4 then
# line 86 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..p].pack('c*').strip
    action = value.split(" ").last
    p action
    @actions << {seat: 'all', action: ACTIONS.fetch(action,nil), amount: nil}
    cp = p;
  		end
when 5 then
# line 126 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 @command = COMMANDS['nh']; cp = p 		end
when 6 then
# line 161 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 cp = p 		end
when 7 then
# line 162 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 cp = p		end
when 8 then
# line 163 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp =p		end
when 9 then
# line 164 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 13 then
# line 1 "NONE"
		begin
te = p+1
		end
when 14 then
# line 161 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
act = 2;		end
when 15 then
# line 163 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
act = 4;		end
when 16 then
# line 160 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p+1
		end
when 17 then
# line 160 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 18 then
# line 161 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 19 then
# line 162 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 20 then
# line 163 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 21 then
# line 164 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 22 then
# line 160 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 23 then
# line 163 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 24 then
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
# line 769 "lib/fb_pokerbot_parser/message_parser.rb"
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
when 10 then
# line 1 "NONE"
		begin
ts = nil;		end
when 11 then
# line 1 "NONE"
		begin
act = 0
		end
# line 794 "lib/fb_pokerbot_parser/message_parser.rb"
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

# line 191 "lib/fb_pokerbot_parser/message_parser.rl"
  end
    
end