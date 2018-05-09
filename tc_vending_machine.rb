require_relative "vending_machine"
require_relative "coin"
require "test/unit"

# Test coin objects used for testing the vending achine
class TestCoin < Test::Unit::TestCase
  # weights obtained from corresponding wikipedia pages
  # coins are not aware of their value per instructions
  def setup
    @penny = Coin.new(19.05, 2.5)
    @nickel = Coin.new(21.21, 5)
    @dime = Coin.new(17.91, 2.5)
    @quarter = Coin.new(24.26, 5.67)
    # not using silver quarter
    #assuming person would rather coin returned due to value
  end


  def test_PennySpecs
    assert_equal(19.05, @penny.getSize())
    assert_equal(2.5, @penny.getWeight())
  end

  def test_NickSpecs
    assert_equal(21.21, @nickel.getSize())
    assert_equal(5, @nickel.getWeight())
  end

  def test_DimeSpecs
    assert_equal(17.91, @dime.getSize())
    assert_equal(2.5, @dime.getWeight())
  end

  def test_QuarterSpecs
    assert_equal(24.26, @quarter.getSize())
    assert_equal(5.67, @quarter.getWeight())
  end
end
