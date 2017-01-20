require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'number-theory'))

include NumberTheory

class TestUtils < Test::Unit::TestCase

  def test_mod_exp
    assert_equal 1, Utils.mod_exp(123, 0, 234)
    assert_equal 445, Utils.mod_exp(4, 13, 497)
    assert_equal 2452785, Utils.mod_exp(1777, 1885, 100000001)
    assert_equal 252276857, Utils.mod_exp(54321, 98765, 2147483647)
    assert_equal 86, Utils.mod_exp(4, -13, 497)
    assert_equal 9159955, Utils.mod_exp(1777, -1885, 100000001)
    assert_equal 1899303417, Utils.mod_exp(54321, -98765, 2147483647)
  end

  def test_mod_inv
    assert_equal 6, Utils.mod_inv(3, 17)
    assert_equal 287173581, Utils.mod_inv(116003, 1500450271)
    assert_equal 50186303895605983691, Utils.mod_inv(5915587277, 54673257461630679457)
  end

end