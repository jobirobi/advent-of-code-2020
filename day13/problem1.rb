schedule = "1007153
29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,433,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,19,x,x,x,23,x,x,x,x,x,x,x,977,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41".split(/[,\n]/)

arrival = schedule[0].to_i
waits = Hash.new
schedule[1..-1].each { |freq|
  next if freq == 'x'
  freq = freq.to_i

  # arrival / freq + 1 is the Nth cycle that the first freq bus arrives
  # (since none of the buses are perfectly timed such that N*freq=arrival)
  # eg. arrival = 45, freq = 11, arrival / freq + 1 = 4 + 1 = 5: the 5th bus (at t=55) is the first 11 bus
  waits[freq] = (arrival / freq + 1) * freq - arrival
}

waits = waits.sort_by{ |k, v| v }
puts waits[0][0] * waits[0][1]
