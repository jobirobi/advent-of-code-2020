player_1 = [
  14,
  29,
  25,
  17,
  13,
  50,
  33,
  32,
  7,
  37,
  26,
  34,
  46,
  24,
  3,
  28,
  18,
  20,
  11,
  1,
  21,
  8,
  44,
  10,
  22
]

player_2 = [
  5,
  38,
  27,
  15,
  45,
  40,
  43,
  30,
  35,
  9,
  48,
  12,
  16,
  47,
  42,
  4,
  2,
  31,
  41,
  39,
  23,
  19,
  36,
  49,
  6
]

# the game is over once someone is out of cards
until player_1.length == 0 or player_2.length == 0

  # the winner of the round takes their own card and the opponent's card, in that order,
  #   and puts them on the bottom of their own deck
  if player_1[0] > player_2[0]
    cards = [player_1.shift, player_2.shift]
    player_1 += cards
  else
    cards = [player_2.shift, player_1.shift]
    player_2 += cards
  end
end

# the score is the sum of the winner's deck multiplied element-wise by [50, 49, 48, ...]
if player_1.length == 0
  puts "#{player_2.zip((1..player_2.length).to_a.reverse).map{ |a, b| a * b }.sum}"
else
  puts "#{player_1.zip((1..player_1.length).to_a.reverse).map{ |a, b| a * b }.sum}"
end
