require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'number-theory'))

include NumberTheory

class TestPrimes < Test::Unit::TestCase

  def test__trial_division
    assert(!Primes._trial_division(1))
    assert(Primes._trial_division(2))
    assert(!Primes._trial_division(24680))
    assert(Primes._trial_division(982451653))
    assert(Primes._trial_division(1882341361))
  end

  def test__miller_rabin
    assert(!Primes._miller_rabin(24680))
    assert(Primes._miller_rabin(982451653))
    assert(Primes._miller_rabin(1882341361))
    assert(Primes._miller_rabin(9007199254740881))
    assert(Primes._miller_rabin(9007199254740881))
  end

  def test_prime?
    assert(!Primes.prime?(1))
    assert(Primes.prime?(2))
    assert(!Primes.prime?(24680))
    assert(Primes.prime?(982451653))
    assert(Primes.prime?(1882341361))
    assert(Primes.prime?(9007199254740881))
    assert(Primes.prime?(66405897020462343733))
    assert(Primes.prime?(416064700201658306196320137931))
    assert(Primes.prime?(6847944682037444681162770672798288913849))
    assert(Primes.prime?(95647806479275528135733781266203904794419563064407))
    assert(Primes.prime?(669483106578092405936560831017556154622901950048903016651289))
    assert(Primes.prime?(2367495770217142995264827948666809233066409497699870112003149352380375124855230068487109373226251983))
  end

  def test_primes_list
    assert_equal [2, 3, 5, 7], Primes.primes_list(10)
    assert_equal [11, 13, 17, 19, 23, 29], Primes.primes_list(10, 30)
    assert_equal (1229 - 168), Primes.primes_list(10**3,10**4).size
    assert_equal 9592, Primes.primes_list(10**5).size
  end

  def test_primepi
    assert_equal 4, Primes.primepi(10)
    assert_equal 168, Primes.primepi(10**3)
    assert_equal 78498, Primes.primepi(10**6)
  end

  def test_factor
    assert_equal ({2=>1, 5=>1}), Primes.factor(10)
    assert_equal ({2=>3, 3=>4, 5=>6}), Primes.factor(10125000)
    assert_equal ({10125001=>1}), Primes.factor(10125001)
    assert_equal ({3267000013=>1, 4093082899=>1, 5915587277=>1}), Primes.factor(79103835773176077140539788299)
    assert_equal ({5915587277=>1, 54673257461630679457=>1}), Primes.factor(323424426232167763068694468589)
    assert_equal ({2=>1, 5=>1, 73=>1, 383=>1, 63564265087747=>1, 727719592270351=>1}), Primes.factor(12932983746293756928584532764589230)
  end

  def test_nextprime
    assert_equal 7, Primes.nextprime(5)
    assert_equal 98765432137, Primes.nextprime(98765432100)
    assert_equal 9876543210000000029, Primes.nextprime(9876543210000000000)
  end

  def test_prevprime
    assert_equal 1234567811, Primes.prevprime(1234567890)
    assert_equal 1234567889999999953, Primes.prevprime(1234567890000000000)
  end

  def test_nthprimes
    assert_equal 29, Primes.nthprime(10)
    assert_equal 7919, Primes.nthprime(1000)
    assert_equal 104729, Primes.nthprime(10000)
  end

  def test_primorial
    assert_equal 2310, Primes.primorial(5)
    assert_equal 1922760350154212639070, Primes.primorial(17)
    assert_equal 2305567963945518424753102147331756070, Primes.primorial(25)
  end

end
