adapters = [
  17,
  110,
  146,
  144,
  70,
  57,
  124,
  121,
  134,
  12,
  135,
  120,
  19,
  92,
  6,
  103,
  46,
  56,
  93,
  65,
  14,
  31,
  63,
  41,
  131,
  60,
  73,
  83,
  71,
  37,
  85,
  79,
  13,
  7,
  109,
  24,
  94,
  2,
  30,
  3,
  27,
  77,
  91,
  106,
  123,
  128,
  35,
  26,
  112,
  55,
  97,
  21,
  100,
  88,
  113,
  117,
  25,
  82,
  129,
  66,
  11,
  116,
  64,
  78,
  38,
  99,
  130,
  84,
  98,
  72,
  50,
  36,
  54,
  8,
  34,
  20,
  127,
  1,
  137,
  143,
  76,
  69,
  111,
  136,
  53,
  43,
  140,
  145,
  49,
  122,
  18,
  42
]

# account for the outlet and the device
adapters << 0
adapters.sort!
adapters << adapters[-1] + 3

# we're going to count the number of routes that can lead to each element in the adapters list
# if there are n routes to adapter X, and m routes to adapter Y, and no routes to adapter Z except from X or Y,
#   then there are n + m routes to adapter Z
# starting condition: there is 1 route to the first adapter (which is actually the outlet)
paths = Hash.new 0
paths[0] = 1
adapters[0...-1].each do |here|
  [1, 2, 3].each do |lookahead|

    # a valid route forward is one which is +1, +2, or +3 jolts above a given point
    there = here + lookahead

    # if you can get there from here, add paths[here] to paths[there]
    if adapters.include? there
      paths[there] += paths[here]
    end

  end
end

# how many paths lead to the device?
puts paths[adapters[-1]]
