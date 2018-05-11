require_relative "tc_coin"
require_relative "tc_display"
require_relative "vending_machine"
require "test/unit"

class TestVendingMachine < Test::Unit::TestCase

  def setup
    @penny = Penny.new()
    @nickel = Nickel.new()
    @dime = Dime.new()
    @quarter = Quarter.new()
    @display = Display.new()
    @vending_machine = VendingMachine.new(@display)
  end

  def test_VendingMachineAcceptCoinNoCoinsInserted
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineAcceptCoinQuarter
    @vending_machine.acceptCoin(@quarter)
    assert_equal("0.25", @vending_machine.checkDisplay())
  end

  def test_VendingMachineAcceptCoinDime
    @vending_machine.acceptCoin(@dime)
    assert_equal("0.10", @vending_machine.checkDisplay())
  end

end
