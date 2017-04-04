
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



# line 170 "lib/fb_pokerbot_parser/message_parser.rl"

# %



  def initialize(data)
    
# line 63 "lib/fb_pokerbot_parser/message_parser.rb"
class << self
	attr_accessor :_pokerbot_actions
	private :_pokerbot_actions, :_pokerbot_actions=
end
self._pokerbot_actions = [
	0, 1, 0, 1, 4, 1, 5, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 14, 1, 
	17, 1, 18, 1, 21, 1, 22, 1, 
	31, 1, 32, 1, 33, 1, 34, 1, 
	35, 1, 36, 2, 0, 23, 2, 1, 
	25, 2, 2, 24, 2, 3, 29, 2, 
	4, 26, 2, 4, 28, 2, 5, 26, 
	2, 5, 27, 2, 5, 28, 2, 5, 
	30, 2, 15, 16, 2, 18, 6, 2, 
	18, 19, 2, 18, 20, 3, 0, 1, 
	25, 3, 0, 2, 24
]

class << self
	attr_accessor :_pokerbot_key_offsets
	private :_pokerbot_key_offsets, :_pokerbot_key_offsets=
end
self._pokerbot_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 11, 
	12, 13, 14, 15, 16, 19, 21, 22, 
	23, 24, 27, 38, 39, 47, 49, 50, 
	51, 52, 53, 54, 55, 56, 57, 58, 
	59, 60, 61, 64, 68, 69, 70, 73, 
	79, 80, 81, 82, 83, 84, 85, 86, 
	87, 88, 89, 90, 91, 92, 93, 94, 
	97, 101, 102, 103, 106, 112, 113, 114, 
	115, 116, 117, 118, 119, 120, 121, 122, 
	123, 124, 125, 126, 127, 130, 141, 142, 
	150, 164, 175, 176, 184, 198, 209, 210, 
	218, 219, 220, 221, 222, 223, 224, 225, 
	226, 227, 230, 241, 242, 250, 264, 275, 
	276, 284, 285, 286, 287, 288, 289, 290, 
	291, 292, 293, 294, 298, 307, 308, 309, 
	312, 318, 319, 320, 321, 322, 323, 324, 
	326, 329, 337, 341, 346, 347, 350, 351, 
	352, 353, 354, 355, 356, 360, 361, 362, 
	363, 364, 365, 366, 367, 368, 373, 376, 
	385, 386, 387, 390, 396, 408, 409, 410, 
	413, 419, 420, 421, 422, 423, 425, 428, 
	436, 440, 445, 446, 449, 450, 451, 452, 
	453, 454, 455, 459, 460, 461, 462, 463, 
	464, 465, 466, 467, 468, 469, 474, 476, 
	479, 487, 491, 496, 497, 500, 504, 505, 
	506, 507, 508, 509, 510, 511, 512, 517, 
	518, 520, 522, 522, 524, 524, 525, 526, 
	527, 529, 529, 530, 531, 532, 535, 535, 
	538, 538, 540, 540, 541, 542, 543, 545, 
	547, 547, 548, 549, 550, 553, 558, 562, 
	565, 569, 574, 579, 582, 586, 590, 594, 
	600, 604, 610
]

class << self
	attr_accessor :_pokerbot_trans_keys
	private :_pokerbot_trans_keys, :_pokerbot_trans_keys=
end
self._pokerbot_trans_keys = [
	116, 101, 115, 116, 32, 97, 99, 100, 
	102, 104, 115, 109, 111, 117, 110, 116, 
	32, 9, 13, 48, 57, 97, 114, 100, 
	32, 9, 13, 49, 65, 81, 97, 113, 
	50, 57, 74, 75, 106, 107, 48, 72, 
	83, 104, 115, 67, 68, 99, 100, 101, 
	102, 102, 97, 117, 108, 116, 95, 97, 
	99, 116, 105, 111, 110, 32, 9, 13, 
	97, 99, 102, 109, 108, 108, 32, 9, 
	13, 32, 99, 102, 109, 9, 13, 108, 
	108, 99, 107, 108, 100, 108, 116, 95, 
	97, 99, 116, 105, 111, 110, 32, 9, 
	13, 97, 99, 102, 109, 108, 108, 32, 
	9, 13, 32, 99, 102, 109, 9, 13, 
	108, 108, 99, 107, 108, 100, 108, 111, 
	112, 45, 99, 97, 114, 100, 115, 32, 
	9, 13, 49, 65, 81, 97, 113, 50, 
	57, 74, 75, 106, 107, 48, 72, 83, 
	104, 115, 67, 68, 99, 100, 32, 49, 
	65, 81, 97, 113, 9, 13, 50, 57, 
	74, 75, 106, 107, 49, 65, 81, 97, 
	113, 50, 57, 74, 75, 106, 107, 48, 
	72, 83, 104, 115, 67, 68, 99, 100, 
	32, 49, 65, 81, 97, 113, 9, 13, 
	50, 57, 74, 75, 106, 107, 49, 65, 
	81, 97, 113, 50, 57, 74, 75, 106, 
	107, 48, 72, 83, 104, 115, 67, 68, 
	99, 100, 111, 108, 101, 45, 99, 97, 
	114, 100, 115, 32, 9, 13, 49, 65, 
	81, 97, 113, 50, 57, 74, 75, 106, 
	107, 48, 72, 83, 104, 115, 67, 68, 
	99, 100, 32, 49, 65, 81, 97, 113, 
	9, 13, 50, 57, 74, 75, 106, 107, 
	49, 65, 81, 97, 113, 50, 57, 74, 
	75, 106, 107, 48, 72, 83, 104, 115, 
	67, 68, 99, 100, 101, 97, 116, 95, 
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
	32, 9, 13, 49, 51, 119, 46, 110, 
	48, 57, 97, 104, 101, 111, 117, 97, 
	104, 101, 111, 117, 32, 9, 13, 32, 
	9, 13, 97, 104, 101, 111, 117, 48, 
	57, 97, 104, 101, 111, 117, 97, 104, 
	111, 32, 97, 104, 9, 13, 32, 111, 
	9, 13, 32, 9, 13, 32, 117, 9, 
	13, 32, 9, 13, 48, 57, 32, 97, 
	104, 9, 13, 32, 9, 13, 32, 101, 
	9, 13, 32, 111, 9, 13, 32, 117, 
	9, 13, 32, 97, 104, 111, 9, 13, 
	32, 101, 9, 13, 32, 97, 104, 111, 
	9, 13, 101, 104, 0
]

class << self
	attr_accessor :_pokerbot_single_lengths
	private :_pokerbot_single_lengths, :_pokerbot_single_lengths=
end
self._pokerbot_single_lengths = [
	0, 1, 1, 1, 1, 1, 6, 1, 
	1, 1, 1, 1, 1, 0, 1, 1, 
	1, 1, 5, 1, 4, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 4, 1, 1, 1, 4, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	4, 1, 1, 1, 4, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 5, 1, 4, 
	6, 5, 1, 4, 6, 5, 1, 4, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 5, 1, 4, 6, 5, 1, 
	4, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 2, 9, 1, 1, 1, 
	4, 1, 1, 1, 1, 1, 1, 2, 
	1, 6, 2, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 9, 
	1, 1, 1, 4, 10, 1, 1, 1, 
	4, 1, 1, 1, 1, 2, 1, 6, 
	2, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 2, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 2, 1, 
	6, 2, 1, 1, 1, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	2, 0, 0, 2, 0, 1, 1, 1, 
	2, 0, 1, 1, 1, 1, 0, 1, 
	0, 2, 0, 1, 1, 1, 0, 2, 
	0, 1, 1, 1, 3, 3, 2, 1, 
	2, 1, 3, 1, 2, 2, 2, 4, 
	2, 4, 2
]

class << self
	attr_accessor :_pokerbot_range_lengths
	private :_pokerbot_range_lengths, :_pokerbot_range_lengths=
end
self._pokerbot_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 1, 0, 0, 
	0, 1, 3, 0, 2, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 1, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	0, 0, 0, 1, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 3, 0, 2, 
	4, 3, 0, 2, 4, 3, 0, 2, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 3, 0, 2, 4, 3, 0, 
	2, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 1, 0, 0, 0, 1, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	1, 1, 1, 2, 0, 1, 0, 0, 
	0, 0, 0, 0, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 2, 1, 0, 
	0, 0, 1, 1, 1, 0, 0, 1, 
	1, 0, 0, 0, 0, 0, 1, 1, 
	1, 2, 0, 1, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 2, 0, 1, 
	1, 1, 2, 0, 1, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 2, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 1, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 2, 1, 1, 1, 1, 1, 1, 
	1, 1, 0
]

class << self
	attr_accessor :_pokerbot_index_offsets
	private :_pokerbot_index_offsets, :_pokerbot_index_offsets=
end
self._pokerbot_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 17, 
	19, 21, 23, 25, 27, 30, 32, 34, 
	36, 38, 41, 50, 52, 59, 62, 64, 
	66, 68, 70, 72, 74, 76, 78, 80, 
	82, 84, 86, 89, 94, 96, 98, 101, 
	107, 109, 111, 113, 115, 117, 119, 121, 
	123, 125, 127, 129, 131, 133, 135, 137, 
	140, 145, 147, 149, 152, 158, 160, 162, 
	164, 166, 168, 170, 172, 174, 176, 178, 
	180, 182, 184, 186, 188, 191, 200, 202, 
	209, 220, 229, 231, 238, 249, 258, 260, 
	267, 269, 271, 273, 275, 277, 279, 281, 
	283, 285, 288, 297, 299, 306, 317, 326, 
	328, 335, 337, 339, 341, 343, 345, 347, 
	349, 351, 353, 355, 359, 369, 371, 373, 
	376, 382, 384, 386, 388, 390, 392, 394, 
	397, 400, 408, 412, 416, 418, 421, 423, 
	425, 427, 429, 431, 433, 437, 439, 441, 
	443, 445, 447, 449, 451, 453, 457, 460, 
	470, 472, 474, 477, 483, 495, 497, 499, 
	502, 508, 510, 512, 514, 516, 519, 522, 
	530, 534, 538, 540, 543, 545, 547, 549, 
	551, 553, 555, 559, 561, 563, 565, 567, 
	569, 571, 573, 575, 577, 579, 583, 586, 
	589, 597, 601, 605, 607, 610, 614, 616, 
	618, 620, 622, 624, 626, 628, 630, 634, 
	636, 639, 641, 642, 645, 646, 648, 650, 
	652, 655, 656, 658, 660, 662, 665, 666, 
	669, 670, 673, 674, 676, 678, 680, 682, 
	685, 686, 688, 690, 692, 696, 701, 705, 
	708, 712, 716, 721, 724, 728, 732, 736, 
	742, 746, 752
]

class << self
	attr_accessor :_pokerbot_trans_targs
	private :_pokerbot_trans_targs, :_pokerbot_trans_targs=
end
self._pokerbot_trans_targs = [
	2, 0, 3, 0, 4, 0, 5, 0, 
	6, 0, 7, 14, 21, 67, 88, 105, 
	0, 8, 0, 9, 0, 10, 0, 11, 
	0, 12, 0, 13, 13, 0, 209, 0, 
	15, 0, 16, 0, 17, 0, 18, 18, 
	0, 19, 20, 20, 20, 20, 20, 20, 
	20, 0, 20, 0, 210, 210, 210, 210, 
	210, 210, 0, 22, 46, 0, 23, 0, 
	24, 0, 25, 0, 26, 0, 27, 0, 
	28, 0, 29, 0, 30, 0, 31, 0, 
	32, 0, 33, 0, 34, 0, 35, 35, 
	0, 36, 211, 214, 215, 0, 37, 0, 
	38, 0, 39, 39, 0, 39, 211, 214, 
	215, 39, 0, 41, 208, 212, 208, 43, 
	208, 212, 208, 45, 208, 212, 208, 47, 
	0, 48, 0, 49, 0, 50, 0, 51, 
	0, 52, 0, 53, 0, 54, 0, 55, 
	0, 56, 56, 0, 57, 216, 219, 220, 
	0, 58, 0, 59, 0, 60, 60, 0, 
	60, 216, 219, 220, 60, 0, 62, 208, 
	217, 208, 64, 208, 217, 208, 66, 208, 
	217, 208, 68, 0, 69, 0, 70, 0, 
	71, 0, 72, 0, 73, 0, 74, 0, 
	75, 0, 76, 0, 77, 77, 0, 78, 
	79, 79, 79, 79, 79, 79, 79, 0, 
	79, 0, 80, 80, 80, 80, 80, 80, 
	0, 81, 82, 83, 83, 83, 83, 81, 
	83, 83, 83, 0, 82, 83, 83, 83, 
	83, 83, 83, 83, 0, 83, 0, 84, 
	84, 84, 84, 84, 84, 0, 85, 86, 
	87, 87, 87, 87, 85, 87, 87, 87, 
	0, 86, 87, 87, 87, 87, 87, 87, 
	87, 0, 87, 0, 221, 221, 221, 221, 
	221, 221, 0, 89, 0, 90, 0, 91, 
	0, 92, 0, 93, 0, 94, 0, 95, 
	0, 96, 0, 97, 0, 98, 98, 0, 
	99, 100, 100, 100, 100, 100, 100, 100, 
	0, 100, 0, 101, 101, 101, 101, 101, 
	101, 0, 102, 103, 104, 104, 104, 104, 
	102, 104, 104, 104, 0, 103, 104, 104, 
	104, 104, 104, 104, 104, 0, 104, 0, 
	223, 223, 223, 223, 223, 223, 0, 106, 
	0, 107, 0, 108, 0, 109, 0, 110, 
	0, 111, 0, 112, 0, 113, 0, 114, 
	0, 115, 0, 116, 150, 116, 0, 117, 
	127, 236, 228, 145, 145, 229, 146, 147, 
	0, 118, 0, 119, 0, 120, 120, 0, 
	120, 225, 228, 229, 120, 0, 122, 208, 
	226, 208, 124, 208, 226, 208, 126, 208, 
	226, 208, 128, 144, 0, 129, 129, 208, 
	129, 130, 231, 234, 235, 140, 129, 208, 
	131, 132, 131, 208, 131, 131, 230, 208, 
	133, 208, 131, 131, 208, 135, 208, 232, 
	208, 137, 208, 232, 208, 139, 208, 232, 
	208, 131, 141, 131, 208, 142, 208, 143, 
	208, 133, 208, 128, 0, 128, 0, 128, 
	0, 148, 0, 149, 0, 129, 129, 128, 
	0, 151, 151, 0, 152, 190, 249, 238, 
	202, 202, 240, 203, 204, 0, 153, 0, 
	154, 0, 155, 155, 0, 155, 237, 238, 
	240, 155, 0, 156, 157, 165, 247, 238, 
	185, 185, 240, 186, 187, 156, 208, 158, 
	208, 159, 208, 160, 160, 208, 160, 237, 
	238, 240, 160, 208, 162, 208, 239, 208, 
	164, 208, 239, 208, 166, 182, 208, 167, 
	167, 208, 167, 168, 242, 245, 246, 178, 
	167, 208, 169, 170, 169, 208, 169, 169, 
	241, 208, 171, 208, 169, 169, 208, 173, 
	208, 243, 208, 175, 208, 243, 208, 177, 
	208, 243, 208, 169, 179, 169, 208, 180, 
	208, 181, 208, 171, 208, 166, 208, 184, 
	208, 239, 208, 166, 208, 166, 208, 188, 
	208, 189, 208, 167, 167, 166, 208, 191, 
	201, 0, 192, 192, 208, 192, 193, 242, 
	245, 246, 197, 192, 208, 194, 195, 194, 
	208, 194, 194, 241, 208, 196, 208, 194, 
	194, 208, 194, 198, 194, 208, 199, 208, 
	200, 208, 196, 208, 191, 0, 191, 0, 
	191, 0, 205, 0, 206, 0, 192, 192, 
	191, 0, 208, 208, 1, 250, 0, 209, 
	208, 208, 40, 213, 208, 208, 42, 208, 
	44, 208, 42, 208, 61, 218, 208, 208, 
	63, 208, 65, 208, 63, 208, 222, 222, 
	208, 208, 224, 224, 208, 208, 121, 227, 
	208, 208, 123, 208, 125, 208, 123, 208, 
	230, 208, 134, 233, 208, 208, 136, 208, 
	138, 208, 136, 208, 121, 227, 128, 208, 
	156, 183, 248, 156, 208, 156, 161, 156, 
	208, 156, 156, 208, 156, 163, 156, 208, 
	156, 156, 241, 208, 156, 172, 244, 156, 
	208, 156, 156, 208, 156, 174, 156, 208, 
	156, 176, 156, 208, 156, 174, 156, 208, 
	156, 183, 248, 166, 156, 208, 156, 163, 
	156, 208, 156, 183, 248, 191, 156, 208, 
	207, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 208, 208, 208, 208, 
	208, 208, 208, 208, 0
]

class << self
	attr_accessor :_pokerbot_trans_actions
	private :_pokerbot_trans_actions, :_pokerbot_trans_actions=
end
self._pokerbot_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 19, 19, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 7, 7, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 15, 15, 
	0, 0, 25, 25, 25, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 25, 25, 
	25, 0, 0, 0, 35, 0, 35, 0, 
	35, 0, 35, 0, 35, 0, 35, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 21, 21, 0, 0, 25, 25, 25, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 25, 25, 25, 0, 0, 0, 39, 
	0, 39, 0, 39, 0, 39, 0, 39, 
	0, 39, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 11, 11, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 9, 9, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 13, 0, 13, 0, 0, 
	0, 79, 25, 0, 0, 25, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 25, 25, 25, 0, 0, 0, 33, 
	0, 33, 0, 33, 0, 33, 0, 33, 
	0, 33, 0, 0, 0, 0, 0, 41, 
	0, 0, 25, 25, 25, 0, 0, 41, 
	0, 0, 0, 41, 0, 0, 0, 41, 
	0, 41, 0, 0, 41, 0, 33, 0, 
	33, 0, 33, 0, 33, 0, 33, 0, 
	33, 0, 0, 0, 41, 0, 41, 0, 
	41, 0, 41, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 17, 17, 0, 0, 0, 82, 25, 
	0, 0, 25, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 25, 25, 
	25, 0, 0, 0, 0, 0, 25, 25, 
	0, 0, 25, 0, 0, 0, 37, 0, 
	37, 0, 37, 0, 0, 37, 0, 25, 
	25, 25, 0, 37, 0, 37, 25, 37, 
	0, 37, 25, 37, 0, 0, 37, 0, 
	0, 37, 0, 0, 25, 25, 25, 0, 
	0, 37, 0, 0, 0, 37, 0, 0, 
	25, 37, 0, 37, 0, 0, 37, 0, 
	37, 25, 37, 0, 37, 25, 37, 0, 
	37, 25, 37, 0, 0, 0, 37, 0, 
	37, 0, 37, 0, 37, 0, 37, 0, 
	37, 25, 37, 0, 37, 0, 37, 0, 
	37, 0, 37, 0, 0, 0, 37, 0, 
	0, 0, 0, 0, 41, 0, 0, 25, 
	25, 25, 0, 0, 41, 0, 0, 0, 
	41, 0, 0, 25, 41, 0, 41, 0, 
	0, 41, 0, 0, 0, 41, 0, 41, 
	0, 41, 0, 41, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 27, 31, 0, 76, 0, 0, 
	52, 43, 0, 25, 64, 64, 0, 64, 
	0, 64, 0, 64, 0, 25, 70, 70, 
	0, 70, 0, 70, 0, 70, 1, 1, 
	85, 46, 1, 1, 89, 49, 0, 25, 
	61, 61, 0, 61, 0, 61, 0, 61, 
	0, 55, 0, 25, 55, 55, 0, 55, 
	0, 55, 0, 55, 0, 25, 0, 61, 
	5, 0, 25, 5, 67, 5, 0, 5, 
	67, 5, 5, 67, 5, 0, 5, 67, 
	3, 3, 25, 58, 3, 0, 25, 3, 
	58, 3, 3, 58, 3, 0, 3, 58, 
	3, 0, 3, 58, 3, 0, 3, 58, 
	5, 0, 25, 0, 5, 67, 5, 0, 
	5, 67, 5, 0, 25, 0, 5, 67, 
	0, 27, 29, 35, 35, 35, 35, 35, 
	35, 39, 39, 39, 39, 39, 39, 33, 
	33, 33, 33, 33, 33, 41, 41, 41, 
	41, 41, 41, 33, 33, 33, 33, 33, 
	33, 41, 41, 41, 41, 37, 37, 37, 
	37, 37, 37, 37, 37, 37, 37, 37, 
	37, 37, 37, 37, 37, 37, 37, 37, 
	37, 37, 37, 37, 37, 37, 37, 37, 
	37, 37, 37, 37, 37, 37, 37, 41, 
	41, 41, 41, 41, 41, 41, 41, 41, 
	41, 31, 52, 43, 64, 64, 64, 64, 
	64, 70, 70, 70, 70, 70, 85, 46, 
	89, 49, 61, 61, 61, 61, 61, 55, 
	55, 55, 55, 55, 55, 61, 67, 67, 
	67, 67, 58, 58, 58, 58, 58, 58, 
	67, 67, 67, 29, 0
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
	73, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0
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
	23, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0
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
	0, 0, 0, 0, 0, 0, 0, 0, 
	761, 761, 761, 761, 761, 761, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 767, 767, 767, 
	767, 767, 767, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 785, 785, 785, 785, 785, 785, 0, 
	833, 833, 833, 833, 833, 833, 785, 785, 
	785, 785, 785, 785, 833, 833, 833, 833, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 823, 823, 823, 823, 
	823, 823, 823, 823, 823, 823, 823, 823, 
	823, 823, 823, 823, 823, 823, 823, 823, 
	823, 823, 823, 823, 823, 823, 823, 823, 
	823, 823, 823, 823, 823, 823, 0, 833, 
	833, 833, 833, 833, 833, 833, 833, 833, 
	833, 0, 0, 0, 0, 0, 0, 834, 
	0, 835, 836, 841, 841, 841, 841, 841, 
	846, 846, 846, 846, 846, 847, 848, 849, 
	850, 862, 862, 862, 862, 862, 861, 861, 
	861, 861, 861, 861, 862, 875, 875, 875, 
	875, 872, 872, 872, 872, 872, 872, 875, 
	875, 875, 876
]

class << self
	attr_accessor :pokerbot_start
end
self.pokerbot_start = 208;
class << self
	attr_accessor :pokerbot_first_final
end
self.pokerbot_first_final = 208;
class << self
	attr_accessor :pokerbot_error
end
self.pokerbot_error = 0;

class << self
	attr_accessor :pokerbot_en_main
end
self.pokerbot_en_main = 208;


# line 177 "lib/fb_pokerbot_parser/message_parser.rl"

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

    
# line 710 "lib/fb_pokerbot_parser/message_parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = pokerbot_start
	ts = nil
	te = nil
	act = 0
end

# line 193 "lib/fb_pokerbot_parser/message_parser.rl"
    
# line 722 "lib/fb_pokerbot_parser/message_parser.rb"
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
			when 17 then
# line 1 "NONE"
		begin
ts = p
		end
# line 756 "lib/fb_pokerbot_parser/message_parser.rb"
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
# line 64 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    @hole_cards = @cards if @cards.count == 2
  		end
when 3 then
# line 68 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..(p-1)].pack('c*').strip
    @amount = value.to_i
    cp = p
  		end
when 4 then
# line 78 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..p].pack('c*').strip
    seat, action, amount = value.split(' ')
    amount = amount.to_i unless amount.nil?
    @actions << {seat: seat, action: ACTIONS.fetch(action,nil), amount: amount}
    cp = p
  		end
when 5 then
# line 86 "lib/fb_pokerbot_parser/message_parser.rl"
		begin

    value = data[cp..p].pack('c*').strip
    action = value.split(" ").last
    p action
    @actions << {seat: 'all', action: ACTIONS.fetch(action,nil), amount: nil}
    cp = p;
  		end
when 6 then
# line 125 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 @command = COMMANDS['nh']; cp = p 		end
when 7 then
# line 160 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 cp = p 		end
when 8 then
# line 161 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 cp = p 		end
when 9 then
# line 162 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 cp = p		end
when 10 then
# line 163 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp =p		end
when 11 then
# line 164 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp =p		end
when 12 then
# line 165 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp =p		end
when 13 then
# line 166 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 14 then
# line 167 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
cp = p		end
when 18 then
# line 1 "NONE"
		begin
te = p+1
		end
when 19 then
# line 163 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
act = 5;		end
when 20 then
# line 165 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
act = 7;		end
when 21 then
# line 159 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p+1
		end
when 22 then
# line 159 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 23 then
# line 160 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 24 then
# line 161 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 25 then
# line 162 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 26 then
# line 163 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 27 then
# line 164 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 28 then
# line 165 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 29 then
# line 166 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 30 then
# line 167 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
te = p
p = p - 1;		end
when 31 then
# line 159 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 32 then
# line 163 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 33 then
# line 164 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 34 then
# line 165 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 35 then
# line 167 "lib/fb_pokerbot_parser/message_parser.rl"
		begin
 begin p = ((te))-1; end
		end
when 36 then
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
# line 1013 "lib/fb_pokerbot_parser/message_parser.rb"
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
when 15 then
# line 1 "NONE"
		begin
ts = nil;		end
when 16 then
# line 1 "NONE"
		begin
act = 0
		end
# line 1038 "lib/fb_pokerbot_parser/message_parser.rb"
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

# line 194 "lib/fb_pokerbot_parser/message_parser.rl"
  end
    
end