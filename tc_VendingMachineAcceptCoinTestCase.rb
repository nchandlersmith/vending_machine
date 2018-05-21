require_relative "CoinClass"
require_relative "VendingMachineTestClass"

class AcceptCoinTest < VendingMachineTest

  def test_NoCoinsInserted
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_AcceptQuarterCheckDisplay
    insertCoinAndVerifyDisplay(@quarter)
  end

  def test_AcceptDimeCheckDisplay
    insertCoinAndVerifyDisplay(@dime)
  end

  def test_AcceptNickelCheckDisplay
    insertCoinAndVerifyDisplay(@nickel)
  end

  def test_RejectPennyCheckDisplayAndCoinReturn
    insertCoinAndVerifyDisplay(@penny)
    coinReturned = @vending_machine.checkCoinReturn()
    assert_instance_of(Penny, coinReturned.pop())
  end

  def test_RejectPenniesAcceptValidCoins
    insertCoinAndVerifyDisplay(@penny)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@penny)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@penny)
    insertCoinAndVerifyDisplay(@nickel)
    insertCoinAndVerifyDisplay(@penny)
  end

end
