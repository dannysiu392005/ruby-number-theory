require_relative 'divisors'

module NumberTheory

  module Congruences
    ##
    # Returns all the incongruent solutions to ax ≡ c (mod m) in ascending order
    #
    # == Example
    #  >> Congruences.congruences_solver(893, 266, 2432) # this solves 893x ≡ 266 (mod 2432)
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

    ##
    # Returns an integer d satifying the following simultaneous congruences
    # x ≡ r1 (mod m1)
    # x ≡ r2 (mod m2)
    # x ≡ r3 (mod m3)
    # and 0 <= d < m1*m2*m3
    # == Example
    #  >> Congruences.chinese_remainder_theorem([2, 3, 2], [3, 5, 7])
    #  => 23
    #  the above solves
    #  # x ≡ 2 (mod 3)
    #  # x ≡ 3 (mod 5)
    #  # x ≡ 2 (mod 7)
    def self.chinese_remainder_theorem(remainders, modulos)
      m1 = modulos[0].abs
      m2 = modulos[1].abs
      m3 = modulos[2].abs
      r1 = remainders[0]
      r2 = remainders[1]
      r3 = remainders[2]
      arr = Divisors.extended_euclidean_algo(m1, m2)
      g1 = arr[0]
      g2 = Divisors.euclidean_algo(m2, m3)
      g3 = Divisors.euclidean_algo(m3, m1)
      if g1 != 1 || g2 != 1 || g3 != 1
        false
      else
        # x ≡ r1 (mod m1) ...... (1)
        # x ≡ r2 (mod m2) ...... (2)
        # x ≡ r3 (mod m3) ...... (3)
        # From (1) and (2), we have m1*q1 + r1 ≡ r2 (mod m2)
        # which means m1*q1 - m2*q2 = r2 - r1
        # So, we can solve this linear congruence equation for x0 which equals m1*q1 + r1
        # Then, we can assume x0 + m1*m2*y ≡ r3 (mod m3)
        # which means m1*m2*y - m3*q3 = r3 - x0
        # So, we have the following solution
        q1 = arr[1] * (r2 - r1)
        x0 = m1 * q1 + r1
        arr2 = Divisors.extended_euclidean_algo(m1*m2, m3)
        x = (arr2[1] * (r3 - x0) * m1 * m2 + x0) % (m1*m2*m3) # Make sure 0 <= x < m1*m2*m3
        x
      end
    end
  end

end
