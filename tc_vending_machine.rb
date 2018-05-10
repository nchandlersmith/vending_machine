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

  def test_VendingMachineDisplayNoCoinsInserted
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

end
