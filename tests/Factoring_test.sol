// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../PFG/Factoring.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {

    Factoring public factoring;
    uint256 public tokens;
    uint256 public ethers;

    function beforeAll() public {
        factoring = new Factoring();
        factoring.DOCnewFile("factura.pdf", 100000000000000000 ,30);
    }

    /// #sender: account-1
    /// #value: 80000000000000000
    function checkStartFactoring() public payable {
        factoring.start{value: msg.value}(1000);
        
        tokens = factoring.LPtokens();
        ethers = factoring.LPether();

        Assert.equal(factoring.LPether(), 80000000000000000, "error value");
        Assert.equal(factoring.LPtokens(), 1000*10**18, "error value");
    }



    /// #sender: account-2
    /// #value: 25800000000000000
    function checkETH2() public payable {
        Assert.ok(factoring.TFAmybalance()==0, "Should have 0 TFAs");
        factoring.LPbuyERC{value: msg.value}();
        Assert.ok(factoring.TFAmybalance()>0, "Should have more than 0 TFAs");
    }

    /// #sender: account-1
    function checkArbit2() public {
        console.log("Arbit: ", tokens-factoring.LPtokens());
        factoring.FINarbit(tokens-factoring.LPtokens());
        factoring.LPbuyETH(tokens-factoring.LPtokens());
        Assert.ok(tokens==factoring.LPtokens(), "Should have same ether as begininng");
    }

    /// #sender: account-3
    /// #value: 34000000000000000
    function checkETH3() public payable {
        Assert.ok(factoring.TFAmybalance()==0, "Should have 0 TFAs");
        factoring.LPbuyERC{value: msg.value}();
        Assert.ok(factoring.TFAmybalance()>0, "Should have more than 0 TFAs");
    }

    /// #sender: account-1
    function checkArbit3() public {
        this.checkArbit2();
    }

    /// #sender: account-4
    /// #value: 13700000000000000
    function checkETH4() public payable {
        Assert.ok(factoring.TFAmybalance()==0, "Should have 0 TFAs");
        factoring.LPbuyERC{value: msg.value}();
        Assert.ok(factoring.TFAmybalance()>0, "Should have more than 0 TFAs");
    }

    /// #sender: account-1
    function checkArbit4() public {
        this.checkArbit2();
    }

    /// #sender: account-5
    /// #value: 20000000000000000
    function checkETH5() public payable {
        Assert.ok(factoring.TFAmybalance()==0, "Should have 0 TFAs");
        factoring.LPbuyERC{value: msg.value}();
        Assert.ok(factoring.TFAmybalance()>0, "Should have more than 0 TFAs");
    }

    /// #sender: account-1
    function checkArbit5() public {
        this.checkArbit2();
    }

    /// #sender: account-6
    /// #value: 12700000000000000
    function checkETH6() public payable {
        Assert.ok(factoring.TFAmybalance()==0, "Should have 0 TFAs");
        factoring.LPbuyERC{value: msg.value}();
        Assert.ok(factoring.TFAmybalance()>0, "Should have more than 0 TFAs");
    }

    /// #sender: account-1
    function checkArbit6() public {
        this.checkArbit2();
    }


    /// #sender: account-7
    /// #value: 53800000000000000
    function checkETH7() public payable {
        Assert.ok(factoring.TFAmybalance()==0, "Should have 0 TFAs");
        factoring.LPbuyERC{value: msg.value}();
        Assert.ok(factoring.TFAmybalance()>0, "Should have more than 0 TFAs");
    }

    /// #sender: account-1
    function checkArbit7() public {
        this.checkArbit2();
    }


    /// #sender: account-8
    /// #value: 31100000000000000
    function checkETH8() public payable {
        Assert.ok(factoring.TFAmybalance()==0, "Should have 0 TFAs");
        factoring.LPbuyERC{value: msg.value}();
        Assert.ok(factoring.TFAmybalance()>0, "Should have more than 0 TFAs");
    }

    /// #sender: account-1
    function checkArbit8() public {
        this.checkArbit2();
    }

    /// #sender: account-1
    /// #value: 196100000000000000
    function checkDepositVALUE() public payable{
        factoring.LPdeposit{value: msg.value}();
        console.log(factoring.TFAsupply());
        Assert.ok(factoring.LPtokens()>tokens, "Should have 0 TFAs");
    }

    /// #sender: account-2
    function checkProfit2() public {
        uint256 beforeBalance = factoring.TFAmybalance();
        uint256 eth_value = factoring.LPether();
        factoring.FINgetProfit();
        Assert.ok(factoring.TFAmybalance()>beforeBalance, "Should have more TFAs");
        Assert.ok(eth_value>factoring.LPether(), "Should have less ETH");
        console.log("Interes: ", factoring.INTrate());
        console.log("Profit TFA: ", factoring.TFAmybalance()-beforeBalance);
        console.log("Profit ETH: ", eth_value-factoring.LPether());
    }

    /// #sender: account-3
    function checkProfit3() public {
        uint256 beforeBalance = factoring.TFAmybalance();
        uint256 eth_value = factoring.LPether();
        factoring.FINgetProfit();
        Assert.ok(factoring.TFAmybalance()>beforeBalance, "Should have more TFAs");
        Assert.ok(eth_value>factoring.LPether(), "Should have less ETH");
        console.log("Interes: ", factoring.INTrate());
        console.log("Profit TFA: ", factoring.TFAmybalance()-beforeBalance);
        console.log("Profit ETH: ", eth_value-factoring.LPether());
    }

    /// #sender: account-4
    function checkProfit4() public {
        uint256 beforeBalance = factoring.TFAmybalance();
        uint256 eth_value = factoring.LPether();
        factoring.FINgetProfit();
        Assert.ok(factoring.TFAmybalance()>beforeBalance, "Should have more TFAs");
        Assert.ok(eth_value>factoring.LPether(), "Should have less ETH");
        console.log("Interes: ", factoring.INTrate());
        console.log("Profit TFA: ", factoring.TFAmybalance()-beforeBalance);
        console.log("Profit ETH: ", eth_value-factoring.LPether());
    }

    /// #sender: account-5
    function checkProfit5() public {
        uint256 beforeBalance = factoring.TFAmybalance();
        uint256 eth_value = factoring.LPether();
        factoring.FINgetProfit();
        Assert.ok(factoring.TFAmybalance()>beforeBalance, "Should have more TFAs");
        Assert.ok(eth_value>factoring.LPether(), "Should have less ETH");
        console.log("Interes: ", factoring.INTrate());
        console.log("Profit TFA: ", factoring.TFAmybalance()-beforeBalance);
        console.log("Profit ETH: ", eth_value-factoring.LPether());
    }

    /// #sender: account-6
    function checkProfit6() public {
        uint256 beforeBalance = factoring.TFAmybalance();
        uint256 eth_value = factoring.LPether();
        factoring.FINgetProfit();
        Assert.ok(factoring.TFAmybalance()>beforeBalance, "Should have more TFAs");
        Assert.ok(eth_value>factoring.LPether(), "Should have less ETH");
        console.log("Interes: ", factoring.INTrate());
        console.log("Profit TFA: ", factoring.TFAmybalance()-beforeBalance);
        console.log("Profit ETH: ", eth_value-factoring.LPether());
    }

    /// #sender: account-7
    function checkProfit7() public {
        uint256 beforeBalance = factoring.TFAmybalance();
        uint256 eth_value = factoring.LPether();
        factoring.FINgetProfit();
        Assert.ok(factoring.TFAmybalance()>beforeBalance, "Should have more TFAs");
        Assert.ok(eth_value>factoring.LPether(), "Should have less ETH");
        console.log("Interes: ", factoring.INTrate());
        console.log("Profit TFA: ", factoring.TFAmybalance()-beforeBalance);
        console.log("Profit ETH: ", eth_value-factoring.LPether());
    }
    
    /// #sender: account-8
    function checkProfit8() public {
        uint256 beforeBalance = factoring.TFAmybalance();
        uint256 eth_value = factoring.LPether();
        factoring.FINgetProfit();
        Assert.ok(factoring.TFAmybalance()>beforeBalance, "Should have more TFAs");
        Assert.ok(eth_value>factoring.LPether(), "Should have less ETH");
        console.log("Interes: ", factoring.INTrate());
        console.log("Profit TFA: ", factoring.TFAmybalance()-beforeBalance);
        console.log("Profit ETH: ", eth_value-factoring.LPether());
    }



}
    