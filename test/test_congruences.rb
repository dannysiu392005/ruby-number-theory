require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'number-theory'))

include NumberTheory

class TestCongruences < Test::Unit::TestCase
  def test_linear_congruences_solver
    # test linear_congruences_solver(a, c, m) which solves ax ≡ c (mod m)
    assert_equal [], Congruences.linear_congruences_solver(3, 5, 6)
    assert_equal [], Congruences.linear_congruences_solver(0, 5, 6)
    assert_equal [1], Congruences.linear_congruences_solver(3, -5, 8)
    p Congruences.linear_congruences_solver(-3, -5, -8)
    assert_equal [1], Congruences.linear_congruences_solver(-3, -5, -8) # treating both a and m are positive integers
    assert_equal 1078, Congruences.linear_congruences_solver(316258250, 2156, 1160718174).size
    assert_equal [82, 210, 338, 466, 594, 722, 850, 978, 1106, 1234, 1362, 1490, 1618, 1746, 1874, 2002, 2130, 2258, 2386], Congruences.linear_congruences_solver(893, 266, 2432)
  end
end
