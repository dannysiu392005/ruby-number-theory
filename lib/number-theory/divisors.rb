require_relative 'utils'
require_relative 'primes'

module NumberTheory

  module Divisors

    ##
    # Returns the greatest integer k such that
    # d^k divides n.
    #
    # == Example
    #  >> Divisors.multiplicity(1000,5)
    #  => 3
    #
    def self.multiplicity(n, d)
      return 0 if n % d != 0
      m, res = n, 0
      while m % d == 0
        m /= d
        res += 1
      end
      res
    end

    ##
    # Returns the ordered list of the divisors of n (1 and n included).
    #
    # == Example
    #  >> Divisors.divisors(100)
    #  => [1, 2, 4, 5, 10, 20, 25, 50, 100]
    #
    def self.divisors(n)
      factors = Primes.factor(n)
      ps = factors.keys.sort!
      self._divisors(0, factors, ps).sort!.uniq
    end

    ## Helper function for divisors
    def self._divisors(n = 0, factors, ps) # :nodoc:
      give = []
      if n == ps.size
        give << 1
      else
        pows = [1]
        factors[ps[n]].times {pows << pows[-1]*ps[n]}
        for q in self._divisors(n+1, factors, ps)
          for p in pows
            give << p * q
          end
        end
      end
      give
    end

    ##
    # Return sigma_0(n), i.e. the number of divisors of n.
    #
    # == Example
    #  >> Divisors.divcount(100)
    #  => 9
    #
    def self.divcount(n)
      return nil if n < 0
      return 1 if n == 1
      divcount = 1
      Primes.factor(n).values.each {|n| divcount *= (n+1)}
      divcount
    end

    ##
    # Returns sigma_k(n), i.e. the sum of the k-th powers of 
    # the divisors of n.
    #
    # == Example
    #  >> Divisors.divisor_sigma(10, 2)
    #  => 130
    #
    def self.divisor_sigma(n, k)
      return self.divcount(n) if k == 0
      res = 0
      for i in self.divisors(n)
        res += i**k
      end
      res
    end

    ##
    # Returns true if n is a perfect number, false otherwise.
    #
    # == Example
    #  >> Divisors.perfect?(6)
    #  => true
    #
    def self.perfect? (n)
      self.divisor_sigma(n, 1) == 2*n
    end


    ##
    # Returns the valuer of phi(n), the Euler phi function; i.e.
    # the number of integers in [1..n] comprime to n. 
    #
    # == Example
    #  >> Divisors.euler_phi(30)
    #  => 8
    #
    #  >> Divisors.euler_phi(37)
    #  => 36
    #
    # == Algorithm
    # n is first factored, then the result is computed as
    # n * prod_{p} (1 - 1/p)
    # where the product spans over all the prime factors of n
    #
    def self.euler_phi(n)
      return 0 if n < 1
      res = n
      Primes.factor(n).keys.each do |i|
        res *= i - 1
        res /= i
      end
      res
    end 

    ##
    # Returns true if a positive integer is square free;
    # returns false otherwise
    #
    # A positive integer 'n' is said to be square free
    # if no prime factor appears more than once
    # in the list of prime factors for 'n'
    #
    # == Example
    #  >> Divisors.square_free?(10)
    #  => true
    #
    # The integer 1 is a special case since it is 
    # both a prefect square, and square free.
    # 
    def self.square_free?(n)
      return false if n <= 0
      (Primes.factor(n)).each_value { |value| return false if value >= 2 }
      true
    end

    ##
    # Returns the greatest common divisor of a and b
    # == Example
    #  >> Divisors.euclidean_algo(20, 15) = 5
    def self.euclidean_algo(a, b)
      a = 0 - a if a < 0
      b = 0 - b if b < 0
      if a == 0 || b == 0
        0
      else
        r = a - (a/b)*b
        while r!=0 do
          a = b
          b = r
          r = a - (a/b)*b
        end
        b
      end
    end

    ##
    # Returns the greatest common divisor of a and b and the corresponding Bézout coefficients
    # for ax + by = g where g is the greatest common divisor of a and b
    # == Example
    #  >> Divisors.extended_euclidean_algo(20, 15) = [5, 1, -1]
    def self.extended_euclidean_algo(a, b)
      a = 0 - a if a < 0
      b = 0 - b if b < 0
      if a == 0 || b == 0
        [0, 0, 0]
      else
        r = a - (a/b)*b
        s0 = 1;                 t0 = 0
        s1 = 0;                 t1 = 1
        s2 = s0 - (a/b)*s1;     t2 = t0 - (a/b)*t1
        while r!=0 do
          a = b
          b = r
          r = a - (a/b)*b
          s0 = s1;              t0 = t1
          s1 = s2;              t1 = t2
          s2 = s0 - (a/b)*s1;   t2 = t0 - (a/b)*t1
        end
        ans = []
        ans << b
        ans << s1
        ans << t1
        ans
      end
    end

    def self.jacobi_symbol(a, n)
      raise ArgumentError.new("#{n} is not a positive odd integer") if n < 0 || n%2 == 0
      return 0 if a%n==0

      numerator = a
      denominator = n
      product = 1

      if numerator < 0
        numerator*=(-1)
        product*=(-1) if denominator%4==3
      end

      while numerator >= 2 do
        tmpProduct = 1
        while numerator%2==0 do
          tmpProduct*=(-1)
          numerator/=2
        end

        if tmpProduct==-1
          r = denominator%8
          product*=(-1) if r==3 || r==5
        end

        if numerator > 2
          tmp = numerator
          numerator = denominator
          denominator = tmp
          numerator = numerator % denominator if numerator > denominator
          product*=(-1) if numerator%4==3 && denominator%4==3
        end
      end

      if numerator == 0
        0
      else
        product
      end
    end

    def self.legendre_symbol(a, p)
      raise ArgumentError.new("#{p} is not an odd prime") if p==2 || !Primes.prime?(p)
      self.jacobi_symbol(a, p)
    end
    
  end

end
