require_relative 'divisors'

module NumberTheory

  module Congruences
    ##
    # Returns all the incongruent solutions to ax ≡ c (mod m) in ascending order
    #
    # == Example
    #  >> Congruences.congruences_solver(893, 266, 2432)
    #  => [82, 210, 338, 466, 594, 722, 850, 978, 1106, 1234, 1362, 1490, 1618, 1746, 1874, 2002, 2130, 2258, 2386]
    #
    def self.linear_congruences_solver(a, c, m)
      return [] if a == 0 || m == 0
      # Assuming both a and m are positive integers
      # If negative values are passed, they will be treated as positive integers
      a = 0 - a if a < 0
      m = 0 - m if m < 0
      arr = Divisors.extended_euclidean_algo(a, m)
      gcd = arr[0]
      if c % gcd != 0
        [] # i.e no solution
      else
        first = (arr[1] * c / gcd) % m
        sol = [first]
        i = 1
        while i < gcd do
          x = first + i * m / gcd
          x -= m if x >= m
          sol << x
          i+=1
        end
        sol.sort
      end
    end
  end

end
