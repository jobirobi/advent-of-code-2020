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

require 'set'

# takes two hands, returns either 1 or 2 (the winner)
def subgame(player_1, player_2)

  # create a checksum to end an infinite game
  checksums = Set.new

  # the game is over once someone is out of cards...
  until player_1.length == 0 or player_2.length == 0

    checksum = [
      player_1.length,
      (player_1 + player_2).map.with_index{ |n, i| 50**i * n }.sum
    ]

    # ...or an infinite game is encountered
    break if checksums.include? checksum
    checksums.add(checksum)

    # simple round
    # the winner of the round takes their own card and the opponent's card, in that order,
    #   and puts them on the bottom of their own deck
    if (player_1.length <= player_1[0]) or (player_2.length <= player_2[0])
      if player_1[0] > player_2[0]
        cards = [player_1.shift, player_2.shift]
        player_1 += cards
      else
        cards = [player_2.shift, player_1.shift]
        player_2 += cards
      end

    # recursive round
    # the winner of the subgame takes the cards
    else
      if subgame(player_1[1..player_1[0]], player_2[1..player_2[0]]) == 1
        cards = [player_1.shift, player_2.shift]
        player_1 += cards
      else
        cards = [player_2.shift, player_1.shift]
        player_2 += cards
      end
    end
  end

  # the only way player_2 wins is by getting player_1 to zero cards
  # if an infinite game is encountered, although both players still have cards, player 1 wins
  return (player_1.length == 0) ? 2 : 1
end


# this is the "primary" game and keeps track of the players' "true" hands
# it looks quite a bit like the subgame function. that's because they're identical minus the return
checksums = Set.new
until player_1.length == 0 or player_2.length == 0

  checksum = [
    player_1.length,
    (player_1 + player_2).map.with_index{ |n, i| 50**i * n }.sum
  ]
  break if checksums.include? checksum
  checksums.add(checksum)

  if (player_1.length <= player_1[0]) or (player_2.length <= player_2[0])
    if player_1[0] > player_2[0]
      cards = [player_1.shift, player_2.shift]
      player_1 += cards
    else
      cards = [player_2.shift, player_1.shift]
      player_2 += cards
    end

  else
    if subgame(player_1[1..player_1[0]], player_2[1..player_2[0]]) == 1
      cards = [player_1.shift, player_2.shift]
      player_1 += cards
    else
      cards = [player_2.shift, player_1.shift]
      player_2 += cards
    end
  end
end

# the score is the sum of the winner's deck multiplied element-wise by [50, 49, 48, ...]
if player_1.length == 0
  puts "#{player_2.zip((1..player_2.length).to_a.reverse).map{ |a, b| a * b }.sum}"
else
  puts "#{player_1.zip((1..player_1.length).to_a.reverse).map{ |a, b| a * b }.sum}"
end
