require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'number-theory'))

include NumberTheory

class TestDivisors < Test::Unit::TestCase

  def test_divisors
    assert_equal [1, 2, 4, 8, 16, 32], Divisors.divisors(32)
    assert_equal [1, 2, 3, 5, 6, 7, 10, 14, 15, 21, 30, 35, 42, 70, 105, 210], Divisors.divisors(210)
  end

  def test_divcount
    assert_equal 16, Divisors.divcount(210)
    assert_equal 36, Divisors.divcount(32000)
    assert_equal 256, Divisors.divcount(3861000)
    assert_equal 12288, Divisors.divcount(4900265546530028103000)
  end

  def test_multiplicity
    assert_equal 1, Divisors.multiplicity(18, 2)
    assert_equal 7, Divisors.multiplicity(34992, 3)
    assert_equal 11, Divisors.multiplicity(8152454278732958496, 19)
  end

  def test_divisor_sigma
    assert_equal 31, Divisors.divisor_sigma(16,1)
    assert_equal 546, Divisors.divisor_sigma(20,2)
    assert_equal 17766056, Divisors.divisor_sigma(28,5)
    assert_equal 170939688, Divisors.divisor_sigma(15,7)
  end

  def test_euler_phi
    assert_equal 4, Divisors.euler_phi(12)
    assert_equal 18, Divisors.euler_phi(19)
    assert_equal 19296, Divisors.euler_phi(25555)
    assert_equal 25032, Divisors.euler_phi(87654)
  end

  def test_perfect?
    assert(Divisors.perfect?(6))
    assert(Divisors.perfect?(496))
    assert(Divisors.perfect?(2305843008139952128))
  end

  def test_square_free?
    assert(Divisors.square_free?(1))
    assert(Divisors.square_free?(110))
    assert(Divisors.square_free?(3226340895))
    assert(Divisors.square_free?(3226340897))
    assert(!Divisors.square_free?(3226340896))
    assert(!Divisors.square_free?(18))
    assert(!Divisors.square_free?(0))
    assert(!Divisors.square_free?(-110))
  end

  def test_euclidean_algo
    assert_equal 1, Divisors.euclidean_algo(1, 2) # Trivial case
    assert_equal 5, Divisors.euclidean_algo(20, 15) # Trivial case
    assert_equal 13, Divisors.euclidean_algo(13, 13) # a = b
    assert_equal 100, Divisors.euclidean_algo(1000, 100) # one is a mulitple of the other
    assert_equal 0, Divisors.euclidean_algo(1000, 0) # one number is zero
    assert_equal 1, Divisors.euclidean_algo(-3, -7) # treat -ve numbers as +ve ones
    assert_equal 1, Divisors.euclidean_algo(99991, 200) # with a prime number
    assert_equal 1078, Divisors.euclidean_algo(1160718174, 316258250)
  end

  def test_extended_euclidean_algo
    assert_equal [1, 1, 0], Divisors.extended_euclidean_algo(1, 2) # Trivial case
    assert_equal [5, 1, -1], Divisors.extended_euclidean_algo(20, 15) # Trivial case
    assert_equal [13, 0, 1], Divisors.extended_euclidean_algo(13, 13) # a = b
    assert_equal [100, 0, 1], Divisors.extended_euclidean_algo(1000, 100) # one is a mulitple of the other
    assert_equal [0, 0, 0], Divisors.extended_euclidean_algo(1000, 0) # one number is zero
    assert_equal [1, -2, 1], Divisors.extended_euclidean_algo(-3, -7) # treat -ve numbers as +ve ones
    assert_equal [1, -89, 44496], Divisors.extended_euclidean_algo(99991, 200) # with a prime number
    assert_equal [1078, 144397, -529960], Divisors.extended_euclidean_algo(1160718174, 316258250)
    assert_equal [1078, -529960, 144397], Divisors.extended_euclidean_algo(316258250, 1160718174)
  end

  def test_jacobi_symbol
    exception = assert_raise(ArgumentError) { Divisors.jacobi_symbol(1, 2) }
    assert_equal "2 is not a positive odd integer", exception.message
    assert_raise(ArgumentError) { Divisors.jacobi_symbol(1, -7) }
    assert_equal 0, Divisors.jacobi_symbol(5*403, 403)
    assert_equal 1, Divisors.jacobi_symbol(1, 5)
    assert_equal -1, Divisors.jacobi_symbol(-1, 9907)
    assert_equal -1, Divisors.jacobi_symbol(2, 9907)
    assert_equal -1, Divisors.jacobi_symbol(1001, 9907)
    assert_equal 1, Divisors.jacobi_symbol(1, 1234567)
    assert_equal -1, Divisors.jacobi_symbol(-1, 1234567)
    assert_equal 1, Divisors.jacobi_symbol(2, 1234567)
    assert_equal 1, Divisors.jacobi_symbol(10000, 1234567)
    assert_equal 0, Divisors.jacobi_symbol(123456789, 1234567891011)
    assert_equal -1, Divisors.jacobi_symbol(4852777, 12408107)
    assert_equal 1, Divisors.jacobi_symbol(17327467, 48746413)
  end

  def test_legendre_symbol
    exception = assert_raise(ArgumentError) { Divisors.legendre_symbol(1, 2) }
    assert_equal "2 is not an odd prime", exception.message
    exception = assert_raise(ArgumentError) { Divisors.legendre_symbol(1, 9) }
    assert_equal "9 is not an odd prime", exception.message
    exception = assert_raise(ArgumentError) { Divisors.legendre_symbol(1, -5) }
    assert_equal "-5 is not an odd prime", exception.message
    assert_equal -1, Divisors.legendre_symbol(-1, 11)
    assert_equal -1, Divisors.legendre_symbol(2, 11)
    assert_equal 1, Divisors.legendre_symbol(-1, 13)
    assert_equal -1, Divisors.legendre_symbol(2, 13)
    assert_equal 1, Divisors.legendre_symbol(2, 17)
    assert_equal -1, Divisors.legendre_symbol(-1, 23)
    assert_equal 1, Divisors.legendre_symbol(2, 23)
    assert_equal 1, Divisors.legendre_symbol(-1, 9007199254740881)
    assert_equal 1, Divisors.legendre_symbol(2, 9007199254740881)
    assert_equal 1, Divisors.legendre_symbol(1882341361, 9007199254740881)
  end

end
