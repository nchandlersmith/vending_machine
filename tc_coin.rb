require_relative "coin"
require "test/unit"

# Test coin objects used for testing the vending achine
class TestCoin < Test::Unit::TestCase
  # weights obtained from corresponding wikipedia pages
  # coins are not aware of their value per instructions
  def setup
    @penny = Penny.new()
    @nickel = Nickel.new()
    @dime = Dime.new()
    @quarter = Quarter.new()
  end

  def test_PennySpecs
    assert_equal(19.05, @penny.getDiameter())
    assert_equal(2.5, @penny.getMass())
  end

  def test_NickSpecs
    assert_equal(21.21, @nickel.getDiameter())
    assert_equal(5, @nickel.getMass())
  end

  def test_DimeSpecs
    assert_equal(17.91, @dime.getDiameter())
    assert_equal(2.5, @dime.getMass())
  end

  def test_QuarterSpecs
    assert_equal(24.26, @quarter.getDiameter())
    assert_equal(5.67, @quarter.getMass())
  end
end
