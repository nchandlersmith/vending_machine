require_relative "tc_CoinTestCase"
require_relative "VendingMachineTestClass"

class SoldOutTest < VendingMachineTest

  def test_VendingMachineSoldOutCola
    @vending_machine.adjustColaStock(-1)
    for i in 1..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    @vending_machine.colaButtonPressed()
    assert_equal("SOLD OUT", @vending_machine.checkDisplay())
    assert_equal("$1.00", @vending_machine.checkDisplay())
    assert_equal("$1.00", @vending_machine.checkDisplay())
  end

  def test_VendingMachineSoldOutChips
    @vending_machine.adjustChipsStock(-1)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    @vending_machine.chipsButtonPressed()
    assert_equal("SOLD OUT", @vending_machine.checkDisplay())
    assert_equal("$0.65", @vending_machine.checkDisplay())
    assert_equal("$0.65", @vending_machine.checkDisplay())
  end

end
