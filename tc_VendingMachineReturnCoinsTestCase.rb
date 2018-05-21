require_relative "CoinClass"
require_relative "VendingMachineTestClass"

class ReturnCoinsTest < VendingMachineTest

  def test_VendingMachineReturnCoins1Quarter
    insertCoinAndVerifyDisplay(@quarter)
    @vending_machine.requestCoinReturn()
    returnInCoins = @vending_machine.checkCoinReturn()
    assert_instance_of(Quarter, returnInCoins[0])
    assert_equal(1, returnInCoins.count())
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineReturnCoins1Quarter1Dime
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    @vending_machine.requestCoinReturn()
    returnInCoins = @vending_machine.checkCoinReturn()
    assert_instance_of(Quarter, returnInCoins[0])
    assert_instance_of(Dime, returnInCoins[1])
    assert_equal(2, returnInCoins.count())
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

    def test_VendingMachineReturnCoins1Quarter1Penny1Dime1Nickel
      insertCoinAndVerifyDisplay(@quarter)
      insertCoinAndVerifyDisplay(@penny)
      insertCoinAndVerifyDisplay(@dime)
      insertCoinAndVerifyDisplay(@nickel)
      @vending_machine.requestCoinReturn()
      returnInCoins = @vending_machine.checkCoinReturn()
      assert_instance_of(Penny, returnInCoins[0])
      assert_instance_of(Quarter, returnInCoins[1])
      assert_instance_of(Dime, returnInCoins[2])
      assert_instance_of(Nickel, returnInCoins[3])
      assert_equal(4, returnInCoins.count())
      assert_equal("INSERT COIN", @vending_machine.checkDisplay())
    end

end
