input = "..##.##.
#.#..###
##.#.#.#
#.#.##.#
###..#..
.#.#..##
#.##.###
#.#..##.".split

cubes = Hash.new false

yrange = input.length
xrange = input[0].length

(0...yrange).each { |y|
  (0...xrange).each { |x|
    cubes[[x, y, 0]] = (input[y][x] == '#')
  }
}

neighbors = lambda { |x, y, z|
  [
    [x-1, y-1, z-1],
    [x-1, y-1, z],
    [x-1, y-1, z+1],
    [x-1, y, z-1],
    [x-1, y, z],
    [x-1, y, z+1],
    [x-1, y+1, z-1],
    [x-1, y+1, z],
    [x-1, y+1, z+1],
    [x, y-1, z-1],
    [x, y-1, z],
    [x, y-1, z+1],
    [x, y, z-1],
    [x, y, z+1],
    [x, y+1, z-1],
    [x, y+1, z],
    [x, y+1, z+1],
    [x+1, y-1, z-1],
    [x+1, y-1, z],
    [x+1, y-1, z+1],
    [x+1, y, z-1],
    [x+1, y, z],
    [x+1, y, z+1],
    [x+1, y+1, z-1],
    [x+1, y+1, z],
    [x+1, y+1, z+1]
  ]
}

(1..6).each { |cycle|
  oldcubes = cubes.dup
  (-cycle...yrange + cycle).each { |y|
    (-cycle...xrange + cycle).each { |x|
      (-cycle..cycle).each { |z|
        n = neighbors.(x, y, z).map{ |xn, yn, zn| oldcubes[[xn, yn, zn]] }.count(true)
        if cubes[[x, y, z]]
          cubes[[x, y, z]] = ((n == 2) or (n == 3))
        else
          cubes[[x, y, z]] = (n == 3)
        end
      }
    }
  }
}

puts cubes.values.count(true)
