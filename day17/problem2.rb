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
    cubes[[x, y, 0, 0]] = (input[y][x] == '#')
  }
}

neighbors = lambda { |x, y, z, w|
  [
    [x-1, y-1, z-1, w-1],
    [x-1, y-1, z, w-1],
    [x-1, y-1, z+1, w-1],
    [x-1, y, z-1, w-1],
    [x-1, y, z, w-1],
    [x-1, y, z+1, w-1],
    [x-1, y+1, z-1, w-1],
    [x-1, y+1, z, w-1],
    [x-1, y+1, z+1, w-1],
    [x, y-1, z-1, w-1],
    [x, y-1, z, w-1],
    [x, y-1, z+1, w-1],
    [x, y, z-1, w-1],
    [x, y, z, w-1],
    [x, y, z+1, w-1],
    [x, y+1, z-1, w-1],
    [x, y+1, z, w-1],
    [x, y+1, z+1, w-1],
    [x+1, y-1, z-1, w-1],
    [x+1, y-1, z, w-1],
    [x+1, y-1, z+1, w-1],
    [x+1, y, z-1, w-1],
    [x+1, y, z, w-1],
    [x+1, y, z+1, w-1],
    [x+1, y+1, z-1, w-1],
    [x+1, y+1, z, w-1],
    [x+1, y+1, z+1, w-1],
    [x-1, y-1, z-1, w],
    [x-1, y-1, z, w],
    [x-1, y-1, z+1, w],
    [x-1, y, z-1, w],
    [x-1, y, z, w],
    [x-1, y, z+1, w],
    [x-1, y+1, z-1, w],
    [x-1, y+1, z, w],
    [x-1, y+1, z+1, w],
    [x, y-1, z-1, w],
    [x, y-1, z, w],
    [x, y-1, z+1, w],
    [x, y, z-1, w],
    [x, y, z+1, w],
    [x, y+1, z-1, w],
    [x, y+1, z, w],
    [x, y+1, z+1, w],
    [x+1, y-1, z-1, w],
    [x+1, y-1, z, w],
    [x+1, y-1, z+1, w],
    [x+1, y, z-1, w],
    [x+1, y, z, w],
    [x+1, y, z+1, w],
    [x+1, y+1, z-1, w],
    [x+1, y+1, z, w],
    [x+1, y+1, z+1, w],
    [x-1, y-1, z-1, w+1],
    [x-1, y-1, z, w+1],
    [x-1, y-1, z+1, w+1],
    [x-1, y, z-1, w+1],
    [x-1, y, z, w+1],
    [x-1, y, z+1, w+1],
    [x-1, y+1, z-1, w+1],
    [x-1, y+1, z, w+1],
    [x-1, y+1, z+1, w+1],
    [x, y-1, z-1, w+1],
    [x, y-1, z, w+1],
    [x, y-1, z+1, w+1],
    [x, y, z-1, w+1],
    [x, y, z, w+1],
    [x, y, z+1, w+1],
    [x, y+1, z-1, w+1],
    [x, y+1, z, w+1],
    [x, y+1, z+1, w+1],
    [x+1, y-1, z-1, w+1],
    [x+1, y-1, z, w+1],
    [x+1, y-1, z+1, w+1],
    [x+1, y, z-1, w+1],
    [x+1, y, z, w+1],
    [x+1, y, z+1, w+1],
    [x+1, y+1, z-1, w+1],
    [x+1, y+1, z, w+1],
    [x+1, y+1, z+1, w+1]
  ]
}

(1..6).each { |cycle|
  oldcubes = cubes.dup
  (-cycle...yrange + cycle).each { |y|
    (-cycle...xrange + cycle).each { |x|
      (-cycle..cycle).each { |z|
        (-cycle..cycle).each { |w|
          n = neighbors.(x, y, z, w).map{ |xn, yn, zn, wn| oldcubes[[xn, yn, zn, wn]] }.count(true)
          if cubes[[x, y, z, w]]
            cubes[[x, y, z, w]] = ((n == 2) or (n == 3))
          else
            cubes[[x, y, z, w]] = (n == 3)
          end
        }
      }
    }
  }
}

puts cubes.values.count(true)
