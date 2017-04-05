
# line 1 "lib/fb_pokerbot_parser/message_parser.rl"

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


# line 195 "lib/fb_pokerbot_parser/message_parser.rl"


  def initialize(data)
    
# line 66 "lib/fb_pokerbot_parser/message_parser.rb"
class << self
	attr_accessor :_pokerbot_actions
	private :_pokerbot_actions, :_pokerbot_actions=
end
self._pokerbot_actions = [
	0, 1, 0, 1, 7, 1, 8, 1, 
	9, 1, 10, 1, 11, 1, 13, 1, 
	14, 1, 15, 1, 16, 1, 17, 1, 
	18, 1, 19, 1, 20, 1, 21, 1, 
	22, 1, 25, 1, 26, 1, 30, 1, 
	31, 1, 42, 1, 43, 1, 44, 1, 
	45, 1, 46, 2, 0, 32, 2, 1, 
	34, 2, 2, 33, 2, 3, 38, 2, 
	4, 39, 2, 5, 40, 2, 6, 41, 
	2, 7, 35, 2, 7, 37, 2, 8, 
	35, 2, 8, 36, 2, 8, 37, 2, 
	23, 24, 2, 26, 12, 2, 26, 27, 
	2, 26, 28, 2, 26, 29, 3, 0, 
	1, 34, 3, 0, 2, 33
]

class << self
	attr_accessor :_pokerbot_key_offsets
	private :_pokerbot_key_offsets, :_pokerbot_key_offsets=
end
self._pokerbot_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 12, 
	13, 14, 15, 18, 19, 23, 28, 29, 
	30, 33, 35, 36, 37, 38, 39, 40, 
	41, 42, 45, 46, 47, 50, 55, 56, 
	57, 58, 59, 62, 64, 67, 69, 70, 
	71, 72, 75, 86, 87, 95, 96, 97, 
	98, 99, 100, 101, 102, 103, 104, 105, 
	106, 107, 108, 111, 115, 116, 117, 120, 
	126, 127, 128, 129, 130, 131, 132, 133, 
	134, 135, 136, 137, 138, 139, 140, 141, 
	144, 155, 156, 164, 178, 192, 193, 201, 
	215, 229, 230, 238, 239, 240, 241, 242, 
	243, 244, 245, 246, 247, 250, 261, 262, 
	270, 284, 298, 299, 307, 309, 310, 311, 
	312, 313, 314, 315, 316, 317, 318, 322, 
	331, 332, 333, 336, 342, 343, 344, 345, 
	346, 347, 348, 350, 353, 361, 365, 370, 
	371, 374, 375, 376, 377, 378, 379, 380, 
	384, 385, 386, 387, 388, 389, 390, 391, 
	392, 397, 400, 409, 410, 411, 414, 420, 
	432, 433, 434, 437, 443, 444, 445, 446, 
	447, 449, 452, 460, 464, 469, 470, 473, 
	474, 475, 476, 477, 478, 479, 483, 484, 
	485, 486, 487, 488, 489, 490, 491, 492, 
	493, 498, 500, 503, 511, 515, 520, 521, 
	524, 528, 529, 530, 531, 532, 533, 534, 
	535, 536, 541, 542, 543, 544, 545, 546, 
	547, 548, 549, 550, 553, 554, 555, 558, 
	563, 564, 566, 568, 570, 573, 573, 575, 
	575, 576, 577, 578, 581, 584, 587, 590, 
	592, 592, 593, 594, 595, 597, 599, 599, 
	600, 601, 602, 605, 610, 614, 617, 621, 
	626, 631, 634, 638, 642, 646, 652, 656, 
	662, 664
]

class << self
	attr_accessor :_pokerbot_trans_keys
	private :_pokerbot_trans_keys, :_pokerbot_trans_keys=
end
self._pokerbot_trans_keys = [
	116, 101, 115, 116, 32, 97, 98, 99, 
	100, 102, 104, 115, 110, 116, 101, 32, 
	9, 13, 97, 32, 110, 9, 13, 32, 
	9, 13, 48, 57, 116, 101, 32, 9, 
	13, 105, 108, 103, 95, 98, 108, 105, 
	110, 100, 32, 9, 13, 98, 98, 32, 
	9, 13, 32, 9, 13, 48, 57, 105, 
	110, 100, 115, 32, 9, 13, 48, 57, 
	47, 48, 57, 48, 57, 97, 114, 100, 
	32, 9, 13, 49, 65, 81, 97, 113, 
	50, 57, 74, 75, 106, 107, 48, 72, 
	83, 104, 115, 67, 68, 99, 100, 101, 
	102, 97, 117, 108, 116, 95, 97, 99, 
	116, 105, 111, 110, 32, 9, 13, 97, 
	99, 102, 109, 108, 108, 32, 9, 13, 
	32, 99, 102, 109, 9, 13, 108, 108, 
	99, 107, 108, 100, 108, 111, 112, 45, 
	99, 97, 114, 100, 115, 32, 9, 13, 
	49, 65, 81, 97, 113, 50, 57, 74, 
	75, 106, 107, 48, 72, 83, 104, 115, 
	67, 68, 99, 100, 32, 49, 65, 81, 
	97, 113, 9, 13, 50, 57, 74, 75, 
	106, 107, 32, 49, 65, 81, 97, 113, 
	9, 13, 50, 57, 74, 75, 106, 107, 
	48, 72, 83, 104, 115, 67, 68, 99, 
	100, 32, 49, 65, 81, 97, 113, 9, 
	13, 50, 57, 74, 75, 106, 107, 32, 
	49, 65, 81, 97, 113, 9, 13, 50, 
	57, 74, 75, 106, 107, 48, 72, 83, 
	104, 115, 67, 68, 99, 100, 111, 108, 
	101, 45, 99, 97, 114, 100, 115, 32, 
	9, 13, 49, 65, 81, 97, 113, 50, 
	57, 74, 75, 106, 107, 48, 72, 83, 
	104, 115, 67, 68, 99, 100, 32, 49, 
	65, 81, 97, 113, 9, 13, 50, 57, 
	74, 75, 106, 107, 32, 49, 65, 81, 
	97, 113, 9, 13, 50, 57, 74, 75, 
	106, 107, 48, 72, 83, 104, 115, 67, 
	68, 99, 100, 101, 109, 97, 116, 95, 
	97, 99, 116, 105, 111, 110, 32, 115, 
	9, 13, 97, 98, 99, 102, 104, 108, 
	109, 115, 117, 108, 108, 32, 9, 13, 
	32, 99, 102, 109, 9, 13, 108, 108, 
	99, 107, 108, 100, 98, 116, 32, 9, 
	13, 32, 98, 99, 102, 109, 114, 9, 
	13, 32, 101, 9, 13, 32, 9, 13, 
	48, 57, 116, 32, 9, 13, 108, 108, 
	99, 107, 108, 100, 32, 97, 9, 13, 
	105, 115, 101, 110, 106, 98, 116, 103, 
	32, 9, 13, 49, 51, 32, 9, 13, 
	97, 98, 99, 102, 104, 108, 109, 115, 
	117, 108, 108, 32, 9, 13, 32, 99, 
	102, 109, 9, 13, 32, 97, 98, 99, 
	102, 104, 108, 109, 115, 117, 9, 13, 
	108, 108, 32, 9, 13, 32, 99, 102, 
	109, 9, 13, 108, 100, 99, 107, 98, 
	116, 32, 9, 13, 32, 98, 99, 102, 
	109, 114, 9, 13, 32, 101, 9, 13, 
	32, 9, 13, 48, 57, 116, 32, 9, 
	13, 108, 108, 99, 107, 108, 100, 32, 
	97, 9, 13, 105, 115, 101, 110, 108, 
	108, 106, 98, 116, 103, 32, 9, 13, 
	49, 51, 98, 116, 32, 9, 13, 32, 
	98, 99, 102, 109, 114, 9, 13, 32, 
	101, 9, 13, 32, 9, 13, 48, 57, 
	116, 32, 9, 13, 32, 97, 9, 13, 
	105, 115, 101, 110, 106, 98, 116, 103, 
	32, 9, 13, 49, 51, 97, 108, 108, 
	95, 98, 108, 105, 110, 100, 32, 9, 
	13, 115, 98, 32, 9, 13, 32, 9, 
	13, 48, 57, 119, 46, 110, 48, 57, 
	48, 57, 47, 48, 57, 97, 104, 101, 
	111, 117, 32, 9, 13, 32, 9, 13, 
	32, 9, 13, 32, 9, 13, 97, 104, 
	101, 111, 117, 48, 57, 97, 104, 101, 
	111, 117, 97, 104, 111, 32, 97, 104, 
	9, 13, 32, 111, 9, 13, 32, 9, 
	13, 32, 117, 9, 13, 32, 9, 13, 
	48, 57, 32, 97, 104, 9, 13, 32, 
	9, 13, 32, 101, 9, 13, 32, 111, 
	9, 13, 32, 117, 9, 13, 32, 97, 
	104, 111, 9, 13, 32, 101, 9, 13, 
	32, 97, 104, 111, 9, 13, 48, 57, 
	101, 104, 0
]

class << self
	attr_accessor :_pokerbot_single_lengths
	private :_pokerbot_single_lengths, :_pokerbot_single_lengths=
end
self._pokerbot_single_lengths = [
	0, 1, 1, 1, 1, 1, 7, 1, 
	1, 1, 1, 1, 2, 1, 1, 1, 
	1, 2, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 0, 1, 0, 1, 1, 
	1, 1, 5, 1, 4, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 4, 1, 1, 1, 4, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	5, 1, 4, 6, 6, 1, 4, 6, 
	6, 1, 4, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 5, 1, 4, 
	6, 6, 1, 4, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 2, 9, 
	1, 1, 1, 4, 1, 1, 1, 1, 
	1, 1, 2, 1, 6, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 2, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 9, 1, 1, 1, 4, 10, 
	1, 1, 1, 4, 1, 1, 1, 1, 
	2, 1, 6, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 2, 1, 6, 2, 1, 1, 1, 
	2, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 2, 0, 0, 1, 0, 2, 0, 
	1, 1, 1, 1, 1, 1, 1, 2, 
	0, 1, 1, 1, 0, 2, 0, 1, 
	1, 1, 3, 3, 2, 1, 2, 1, 
	3, 1, 2, 2, 2, 4, 2, 4, 
	0, 2
]

class << self
	attr_accessor :_pokerbot_range_lengths
	private :_pokerbot_range_lengths, :_pokerbot_range_lengths=
end
self._pokerbot_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 1, 2, 0, 0, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 1, 2, 0, 0, 
	0, 0, 1, 1, 1, 1, 0, 0, 
	0, 1, 3, 0, 2, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 1, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	3, 0, 2, 4, 4, 0, 2, 4, 
	4, 0, 2, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 3, 0, 2, 
	4, 4, 0, 2, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 1, 1, 0, 0, 0, 0, 
	0, 0, 0, 1, 1, 1, 2, 0, 
	1, 0, 0, 0, 0, 0, 0, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	2, 1, 0, 0, 0, 1, 1, 1, 
	0, 0, 1, 1, 0, 0, 0, 0, 
	0, 1, 1, 1, 2, 0, 1, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	2, 0, 1, 1, 1, 2, 0, 1, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 2, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 1, 0, 0, 1, 2, 
	0, 0, 1, 1, 1, 0, 0, 0, 
	0, 0, 0, 1, 1, 1, 1, 0, 
	0, 0, 0, 0, 1, 0, 0, 0, 
	0, 0, 0, 1, 1, 1, 1, 2, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 0
]

class << self
	attr_accessor :_pokerbot_index_offsets
	private :_pokerbot_index_offsets, :_pokerbot_index_offsets=
end
self._pokerbot_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 18, 
	20, 22, 24, 27, 29, 33, 37, 39, 
	41, 44, 47, 49, 51, 53, 55, 57, 
	59, 61, 64, 66, 68, 71, 75, 77, 
	79, 81, 83, 86, 88, 91, 93, 95, 
	97, 99, 102, 111, 113, 120, 122, 124, 
	126, 128, 130, 132, 134, 136, 138, 140, 
	142, 144, 146, 149, 154, 156, 158, 161, 
	167, 169, 171, 173, 175, 177, 179, 181, 
	183, 185, 187, 189, 191, 193, 195, 197, 
	200, 209, 211, 218, 229, 240, 242, 249, 
	260, 271, 273, 280, 282, 284, 286, 288, 
	290, 292, 294, 296, 298, 301, 310, 312, 
	319, 330, 341, 343, 350, 353, 355, 357, 
	359, 361, 363, 365, 367, 369, 371, 375, 
	385, 387, 389, 392, 398, 400, 402, 404, 
	406, 408, 410, 413, 416, 424, 428, 432, 
	434, 437, 439, 441, 443, 445, 447, 449, 
	453, 455, 457, 459, 461, 463, 465, 467, 
	469, 473, 476, 486, 488, 490, 493, 499, 
	511, 513, 515, 518, 524, 526, 528, 530, 
	532, 535, 538, 546, 550, 554, 556, 559, 
	561, 563, 565, 567, 569, 571, 575, 577, 
	579, 581, 583, 585, 587, 589, 591, 593, 
	595, 599, 602, 605, 613, 617, 621, 623, 
	626, 630, 632, 634, 636, 638, 640, 642, 
	644, 646, 650, 652, 654, 656, 658, 660, 
	662, 664, 666, 668, 671, 673, 675, 678, 
	682, 684, 687, 689, 691, 694, 695, 698, 
	699, 701, 703, 705, 708, 711, 714, 717, 
	720, 721, 723, 725, 727, 729, 732, 733, 
	735, 737, 739, 743, 748, 752, 755, 759, 
	763, 768, 771, 775, 779, 783, 789, 793, 
	799, 801
]

class << self
	attr_accessor :_pokerbot_trans_targs
	private :_pokerbot_trans_targs, :_pokerbot_trans_targs=
end
self._pokerbot_trans_targs = [
	2, 0, 3, 0, 4, 0, 5, 0, 
	6, 0, 7, 17, 38, 45, 70, 91, 
	108, 0, 8, 0, 9, 0, 10, 0, 
	11, 11, 0, 12, 0, 13, 14, 13, 
	0, 13, 13, 226, 0, 15, 0, 16, 
	0, 13, 13, 0, 18, 30, 0, 19, 
	0, 20, 0, 21, 0, 22, 0, 23, 
	0, 24, 0, 25, 0, 26, 26, 0, 
	27, 0, 28, 0, 29, 29, 0, 29, 
	29, 227, 0, 31, 0, 32, 0, 33, 
	0, 34, 0, 35, 35, 0, 36, 0, 
	37, 36, 0, 228, 225, 39, 0, 40, 
	0, 41, 0, 42, 42, 0, 43, 44, 
	44, 44, 44, 44, 44, 44, 0, 44, 
	0, 229, 229, 229, 229, 229, 229, 0, 
	46, 0, 47, 0, 48, 0, 49, 0, 
	50, 0, 51, 0, 52, 0, 53, 0, 
	54, 0, 55, 0, 56, 0, 57, 0, 
	58, 0, 59, 59, 0, 60, 230, 233, 
	234, 0, 61, 0, 62, 0, 63, 63, 
	0, 63, 230, 233, 234, 63, 0, 65, 
	225, 231, 225, 67, 225, 231, 225, 69, 
	225, 231, 225, 71, 0, 72, 0, 73, 
	0, 74, 0, 75, 0, 76, 0, 77, 
	0, 78, 0, 79, 0, 80, 80, 0, 
	81, 82, 82, 82, 82, 82, 82, 82, 
	0, 82, 0, 83, 83, 83, 83, 83, 
	83, 0, 84, 85, 86, 86, 86, 86, 
	84, 86, 86, 86, 0, 84, 85, 86, 
	86, 86, 86, 84, 86, 86, 86, 0, 
	86, 0, 87, 87, 87, 87, 87, 87, 
	0, 88, 89, 90, 90, 90, 90, 88, 
	90, 90, 90, 0, 88, 89, 90, 90, 
	90, 90, 88, 90, 90, 90, 0, 90, 
	0, 235, 235, 235, 235, 235, 235, 0, 
	92, 0, 93, 0, 94, 0, 95, 0, 
	96, 0, 97, 0, 98, 0, 99, 0, 
	100, 0, 101, 101, 0, 102, 103, 103, 
	103, 103, 103, 103, 103, 0, 103, 0, 
	104, 104, 104, 104, 104, 104, 0, 105, 
	106, 107, 107, 107, 107, 105, 107, 107, 
	107, 0, 105, 106, 107, 107, 107, 107, 
	105, 107, 107, 107, 0, 107, 0, 237, 
	237, 237, 237, 237, 237, 0, 109, 210, 
	0, 110, 0, 111, 0, 112, 0, 113, 
	0, 114, 0, 115, 0, 116, 0, 117, 
	0, 118, 0, 119, 153, 119, 0, 120, 
	130, 250, 242, 148, 148, 243, 149, 150, 
	0, 121, 0, 122, 0, 123, 123, 0, 
	123, 239, 242, 243, 123, 0, 125, 225, 
	240, 225, 127, 225, 240, 225, 129, 225, 
	240, 225, 131, 147, 0, 132, 132, 225, 
	132, 133, 245, 248, 249, 143, 132, 225, 
	134, 135, 134, 225, 134, 134, 244, 225, 
	136, 225, 134, 134, 225, 138, 225, 246, 
	225, 140, 225, 246, 225, 142, 225, 246, 
	225, 134, 144, 134, 225, 145, 225, 146, 
	225, 136, 225, 131, 0, 131, 0, 131, 
	0, 151, 0, 152, 0, 132, 132, 131, 
	0, 154, 154, 0, 155, 193, 263, 252, 
	205, 205, 254, 206, 207, 0, 156, 0, 
	157, 0, 158, 158, 0, 158, 251, 252, 
	254, 158, 0, 159, 160, 168, 261, 252, 
	188, 188, 254, 189, 190, 159, 225, 161, 
	225, 162, 225, 163, 163, 225, 163, 251, 
	252, 254, 163, 225, 165, 225, 253, 225, 
	167, 225, 253, 225, 169, 185, 225, 170, 
	170, 225, 170, 171, 256, 259, 260, 181, 
	170, 225, 172, 173, 172, 225, 172, 172, 
	255, 225, 174, 225, 172, 172, 225, 176, 
	225, 257, 225, 178, 225, 257, 225, 180, 
	225, 257, 225, 172, 182, 172, 225, 183, 
	225, 184, 225, 174, 225, 169, 225, 187, 
	225, 253, 225, 169, 225, 169, 225, 191, 
	225, 192, 225, 170, 170, 169, 225, 194, 
	204, 0, 195, 195, 225, 195, 196, 256, 
	259, 260, 200, 195, 225, 197, 198, 197, 
	225, 197, 197, 255, 225, 199, 225, 197, 
	197, 225, 197, 201, 197, 225, 202, 225, 
	203, 225, 199, 225, 194, 0, 194, 0, 
	194, 0, 208, 0, 209, 0, 195, 195, 
	194, 0, 211, 0, 212, 0, 213, 0, 
	214, 0, 215, 0, 216, 0, 217, 0, 
	218, 0, 219, 0, 220, 220, 0, 221, 
	0, 222, 0, 223, 223, 0, 223, 223, 
	264, 0, 225, 225, 1, 265, 0, 226, 
	225, 227, 225, 37, 228, 225, 225, 64, 
	232, 225, 225, 66, 225, 68, 225, 66, 
	225, 236, 236, 225, 236, 236, 225, 238, 
	238, 225, 238, 238, 225, 124, 241, 225, 
	225, 126, 225, 128, 225, 126, 225, 244, 
	225, 137, 247, 225, 225, 139, 225, 141, 
	225, 139, 225, 124, 241, 131, 225, 159, 
	186, 262, 159, 225, 159, 164, 159, 225, 
	159, 159, 225, 159, 166, 159, 225, 159, 
	159, 255, 225, 159, 175, 258, 159, 225, 
	159, 159, 225, 159, 177, 159, 225, 159, 
	179, 159, 225, 159, 177, 159, 225, 159, 
	186, 262, 169, 159, 225, 159, 166, 159, 
	225, 159, 186, 262, 194, 159, 225, 264, 
	225, 224, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 225, 225, 
	225, 225, 225, 225, 225, 225, 0
]

class << self
	attr_accessor :_pokerbot_trans_actions
	private :_pokerbot_trans_actions, :_pokerbot_trans_actions=
end
self._pokerbot_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	31, 31, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 11, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 27, 27, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 7, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 25, 25, 0, 0, 0, 
	0, 0, 0, 99, 49, 0, 0, 0, 
	0, 0, 0, 13, 13, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 21, 21, 0, 0, 35, 35, 
	35, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 35, 35, 35, 0, 0, 0, 
	45, 0, 45, 0, 45, 0, 45, 0, 
	45, 0, 45, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 17, 17, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 15, 15, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 19, 0, 19, 0, 0, 
	0, 93, 35, 0, 0, 35, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 35, 35, 35, 0, 0, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 0, 0, 0, 0, 49, 
	0, 0, 35, 35, 35, 0, 0, 49, 
	0, 0, 0, 49, 0, 0, 0, 49, 
	0, 49, 0, 0, 49, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 0, 0, 49, 0, 49, 0, 
	49, 0, 49, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 23, 23, 0, 0, 0, 96, 35, 
	0, 0, 35, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 35, 35, 
	35, 0, 0, 0, 0, 0, 35, 35, 
	0, 0, 35, 0, 0, 0, 47, 0, 
	47, 0, 47, 0, 0, 47, 0, 35, 
	35, 35, 0, 47, 0, 47, 35, 47, 
	0, 47, 35, 47, 0, 0, 47, 0, 
	0, 47, 0, 0, 35, 35, 35, 0, 
	0, 47, 0, 0, 0, 47, 0, 0, 
	35, 47, 0, 47, 0, 0, 47, 0, 
	47, 35, 47, 0, 47, 35, 47, 0, 
	47, 35, 47, 0, 0, 0, 47, 0, 
	47, 0, 47, 0, 47, 0, 47, 0, 
	47, 35, 47, 0, 47, 0, 47, 0, 
	47, 0, 47, 0, 0, 0, 47, 0, 
	0, 0, 0, 0, 49, 0, 0, 35, 
	35, 35, 0, 0, 49, 0, 0, 0, 
	49, 0, 0, 35, 49, 0, 49, 0, 
	0, 49, 0, 0, 0, 49, 0, 49, 
	0, 49, 0, 49, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 29, 29, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	9, 0, 37, 41, 0, 90, 0, 0, 
	69, 0, 63, 0, 99, 60, 51, 0, 
	35, 81, 81, 0, 81, 0, 81, 0, 
	81, 1, 1, 102, 0, 0, 54, 1, 
	1, 106, 0, 0, 57, 0, 35, 78, 
	78, 0, 78, 0, 78, 0, 78, 0, 
	72, 0, 35, 72, 72, 0, 72, 0, 
	72, 0, 72, 0, 35, 0, 78, 5, 
	0, 35, 5, 84, 5, 0, 5, 84, 
	5, 5, 84, 5, 0, 5, 84, 3, 
	3, 35, 75, 3, 0, 35, 3, 75, 
	3, 3, 75, 3, 0, 3, 75, 3, 
	0, 3, 75, 3, 0, 3, 75, 5, 
	0, 35, 0, 5, 84, 5, 0, 5, 
	84, 5, 0, 35, 0, 5, 84, 0, 
	66, 0, 37, 39, 49, 45, 45, 45, 
	45, 45, 45, 43, 43, 43, 43, 43, 
	43, 49, 49, 49, 49, 49, 49, 43, 
	43, 43, 43, 43, 43, 49, 49, 49, 
	49, 47, 47, 47, 47, 47, 47, 47, 
	47, 47, 47, 47, 47, 47, 47, 47, 
	47, 47, 47, 47, 47, 47, 47, 47, 
	47, 47, 47, 47, 47, 47, 47, 47, 
	47, 47, 47, 49, 49, 49, 49, 49, 
	49, 49, 49, 49, 49, 41, 69, 63, 
	60, 51, 81, 81, 81, 81, 81, 102, 
	54, 106, 57, 78, 78, 78, 78, 78, 
	72, 72, 72, 72, 72, 72, 78, 84, 
	84, 84, 84, 75, 75, 75, 75, 75, 
	75, 84, 84, 84, 66, 39, 0
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
	0, 87, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0
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
	0, 33, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0
]

class << self
	attr_accessor :_pokerbot_eof_trans
	private :_pokerbot_eof_trans, :_pokerbot_eof_trans=
end
self._pokerbot_eof_trans = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 877, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	811, 811, 811, 811, 811, 811, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 829, 829, 829, 829, 
	829, 829, 0, 877, 877, 877, 877, 877, 
	877, 829, 829, 829, 829, 829, 829, 877, 
	877, 877, 877, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 867, 
	867, 867, 867, 867, 867, 867, 867, 867, 
	867, 867, 867, 867, 867, 867, 867, 867, 
	867, 867, 867, 867, 867, 867, 867, 867, 
	867, 867, 867, 867, 867, 867, 867, 867, 
	867, 0, 877, 877, 877, 877, 877, 877, 
	877, 877, 877, 877, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	878, 0, 879, 880, 881, 882, 887, 887, 
	887, 887, 887, 888, 889, 890, 891, 903, 
	903, 903, 903, 903, 902, 902, 902, 902, 
	902, 902, 903, 916, 916, 916, 916, 913, 
	913, 913, 913, 913, 913, 916, 916, 916, 
	917, 918
]

class << self
	attr_accessor :pokerbot_start
end
self.pokerbot_start = 225;
class << self
	attr_accessor :pokerbot_first_final
end
self.pokerbot_first_final = 225;
class << self
	attr_accessor :pokerbot_error
end
self.pokerbot_error = 0;

class << self
	attr_accessor :pokerbot_en_main
end
self.pokerbot_en_main = 225;


# line 199 "lib/fb_pokerbot_parser/message_parser.rl"
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

    
# line 746 "lib/fb_pokerbot_parser/message_parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = pokerbot_start
	ts = nil
	te = nil
	act = 0
end

# line 215 "lib/fb_pokerbot_parser/message_parser.rl"
    
# line 758 "lib/fb_pokerbot_parser/message_parser.rb"
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
			when 25 then
# line 1 "NONE"
		begin
ts = p
		end
# line 792 "lib/fb_pokerbot_parser/message_parser.rb"
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
# line 60 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    parseCard(data[cp..(p-1)].pack('c*').strip)
    cp = p
  		end
when 1 then
# line 64 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    @flop = @cards if @cards.count == 3
  		end
when 2 then
# line 67 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    @hole_cards = @cards if @cards.count == 2
  		end
when 3 then
# line 77 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    parseBlinds(data[cp..(p-1)].pack('c*').strip)
    cp = p
  		end
when 4 then
# line 82 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    parseBigBlind(data[cp..(p-1)].pack('c*').strip)
    cp = p
  		end
when 5 then
# line 87 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..(p-1)].pack('c*').strip
    @blinds[:sb] = value.to_i
  		end
when 6 then
# line 92 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..(p-1)].pack('c*').strip
    @blinds[:ante] = value.to_i
  		end
when 7 then
# line 97 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..p].pack('c*').strip
    seat, action, amount = value.split(' ')
    amount = amount.to_i unless amount.nil?
    @actions << {seat: seat, action: ACTIONS.fetch(action,nil), amount: amount}
    cp = p
  		end
when 8 then
# line 105 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..p].pack('c*').strip
    action = value.split(" ").last
    @actions << {seat: 'all', action: ACTIONS.fetch(action,nil), amount: nil}
    cp = p
  		end
when 9 then
# line 142 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 10 then
# line 143 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 11 then
# line 144 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 12 then
# line 148 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 @command = COMMANDS['nh']; cp = p 		end
when 13 then
# line 183 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 14 then
# line 184 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 15 then
# line 185 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 16 then
# line 186 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 17 then
# line 187 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 18 then
# line 188 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 19 then
# line 189 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 20 then
# line 190 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 21 then
# line 191 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 22 then
# line 192 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 26 then
# line 1 "NONE"
		begin
te = p+1
		end
when 27 then
# line 186 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
act = 5;		end
when 28 then
# line 188 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
act = 7;		end
when 29 then
# line 189 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
act = 8;		end
when 30 then
# line 182 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p+1
		end
when 31 then
# line 182 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 32 then
# line 183 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 33 then
# line 184 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 34 then
# line 185 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 35 then
# line 186 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 36 then
# line 187 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 37 then
# line 188 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 38 then
# line 189 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 39 then
# line 190 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 40 then
# line 191 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 41 then
# line 192 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 42 then
# line 182 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 43 then
# line 186 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 44 then
# line 187 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 45 then
# line 188 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 46 then
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
# line 1094 "lib/fb_pokerbot_parser/message_parser.rb"
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
when 23 then
# line 1 "NONE"
		begin
ts = nil;		end
when 24 then
# line 1 "NONE"
		begin
act = 0
		end
# line 1119 "lib/fb_pokerbot_parser/message_parser.rb"
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

# line 216 "lib/fb_pokerbot_parser/message_parser.rl"
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

  def parseSmallBlind(data)
  end

  def parseAnte(data)
  end

    
end