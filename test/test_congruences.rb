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

  def test_chinese_remainder_theorem
    assert_equal 23, Congruences.chinese_remainder_theorem([2, 3, 2], [3, 5, 7])
    assert_equal false, Congruences.chinese_remainder_theorem([2, 3, 2], [3, 6, 7]) # as gcd(3, 6) = 2 which is not 1
    assert_equal 1000, Congruences.chinese_remainder_theorem([10, 4, 12], [11, 12, 13])
    assert_equal 8083600090651983754, Congruences.chinese_remainder_theorem([10, 4, 12], [1160718174, 1160718175, 13])
    assert_equal 6725167681631185062030019654, Congruences.chinese_remainder_theorem([10, 4, 12], [2160718174, 2160718175, 2160718177])
  end
end
