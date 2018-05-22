# Vending Machine Code Kata
- Vending machine was implemented according to [these features](https://github.com/PillarTechnology/kata-vending-machine)
- This project was tested and written in Ruby 2.4.4 on a Windows 10 machine.
- Download ruby for Windows [here](https://rubyinstaller.org/downloads/).
- To run the test suite run the following from the terminal `ruby ts_VendingMachineTestSuite.rb` from the cloned repo folder.

## Project structure
This repo contains the following files:
- __VendingMachineClass.rb:__ production code for the vending machine class.
- __ts_VendingMachineTestSuite.rb:__ test suite written in Ruby Test::Unit.
- __CoinClass.rb:__ class definition for the coins. _Note: the coins nor the machine know their value directly. Value is deduced from coin diameter and mass._
- __tc_CoinTestCase.rb__ Test case for testing the coin class and is ran with the test suite.
- __VendingMachine<Feature>TestCase.rb:__ Six test cases are included as part of the test suite. Each test case corresponds to a feature.
- __VendingMachineTestClass.rb:__ Base class from which the feature test case classes inherit.

## Test results
As of 21 May 2018, 42 tests & 241 assertions pass. There are no known issues and all features are implemented.

## Note to reviewer
Thank you for taking the time to review my work.

I have tested and implemented all the features described in the link above. I have finished this project using Ruby and the unit test framework (Unit::Test) from the standard library. When I started this project, I had no knowledge of Ruby syntax. I learned Ruby for this because I figured I could either tell you that I am willing and capable of learning new material or I could demonstrate it. In retrospect, Ruby was a good choice as the unit test framework in the standard library was easy to work with, so it was convenient for me and as the reviewer, it is one less thing to have to manage or install.

Thank you again for taking the time. I look forward to discussing this solution.

Nate Chandler-Smith
