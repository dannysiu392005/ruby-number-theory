require_relative 'utils'
require 'prime'
module Primes

	def self.prime? (n)
		unless n.class.superclass == Integer
			raise ArgumentError
		end

		if n < 10**9 or n % 2 == 0
			return self.trial_division(n)
		else
			return self.miller_rabin(n)
		end
	end

	def self.trial_division (n)
		return false if n <= 1
		return true if n == 2 or n == 3

		mod = n % 6
		return false if mod != 1 and mod != 5
		i = 3
		while i <= n**0.5
			return false if n % i == 0
			i += 2
		end
		return true
	end

	def self.witness (a, n)
		# set n - 1 = 2^t * u 
		t = Utils::Math::high_pow_divisor(n-1, 2)
		u = (n-1)/(2**t)
		# check if a is witness for non-primality of n
		# using fermat theorem
		x1 = Utils::Math::mod_exp(a, u, n)
		t.times do |i|
			x0 = x1
			x1 = (x0 * x0) % n
			if x1 == 1 and x0 != 1 and x0 != n-1
				return true
			end
		end
		return true if x1 != 1
		return false
	end
	  
	def self.miller_rabin (n, runs = 48)
		if n < 341550071728321
			for a in [2, 3, 5, 7, 11, 13, 17] do
				return false if self.witness(a, n)
			end
			return true
		else
			runs.times do
				a = 1 + Random.rand(n)
				if self.witness(a, n)
					return false
				end
			end
			return true
		end
	end

	def self.primerange(low = 1, high)
		return [] if low > high
		arr = Array.new(high + 1, true)
		2.upto(high ** 0.5) do |i|
			if arr[i]
				j = i*i
				while j <= high
					arr[j] = false
					j += i
				end
			end
		end
		primes = []
		arr.each_with_index {|b,i| primes << i if b}
		start = primes.find_index {|n| n > low}
		return primes[start..-1]
	end

	def self.primepi(n)
		if n < 2
			return 0
		else
			return Primes::primerange(n).size
		end
	end

end

count1 = 0
time1 = Utils::Timing::time_once {Primes::primerange(10000000).each {|n| count1 += 1}}
puts "#{count1} primes sieved in #{time1} seconds"