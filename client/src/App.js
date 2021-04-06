import React, { Component } from "react";
import ElektaMainContract from "./contracts/ElektaMain.json";
import getWeb3 from "./getWeb3";

import "./App.css";

class App extends Component {
  state = { storageValue: 0, web3: null, accounts: null, contract: null };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = ElektaMainContract.networks[networkId];
      const instance = new web3.eth.Contract(
        ElektaMainContract.abi,
        deployedNetwork && deployedNetwork.address,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState({ web3, accounts, contract: instance }, this.runExample);
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  runExample = async () => {
    const { accounts, contract } = this.state;

    // Stores a given value, 5 by default.
    //await contract.methods.set(5).send({ from: accounts[0] });

    // Get the value from the contract to prove it worked.
   // const response = await contract.methods.get().call();

    // Update state with the result.
  //  this.setState({ storageValue: response });
  };

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }
    console.log(this.state.contract)
    return (
  
      <main>
      <div className="container-fluid">


        {/* <div><Link href='/dapp'><a>My Dapp</a></Link></div>
    <div><Link href='/accounts'><a>My Accounts</a></Link></div> */}
        <div className="home-container">
          <div className="home-img_container">
            <h1 className="elekta-header">Elekta Movement</h1>
            <img src="../art-works/undraw_voting_nvu7.svg" className="home-img" alt="elekta" />
          </div>
          <div className="home-intro">
            <div className="elekta_card_container">
              <div className="elekta_card card-color-first">
                <div className="elekta_card-content">
                  <a href={this.state.contract.methods.createElektaGroup("Surulere Association", "SUA")
                                                      .send({
                                                        from: this.state.accounts[0],
                                                        gas: 21000,
                                                        gasPrice: '20000000000'
                                                        })}><h1>Create a Group</h1></a>
                  {/* <h1>Create a Group</h1> */}
                </div>

              </div>
              <div className="elekta_card card-color-second">
                <div className="elekta_card-content">
                <a href={this.state.contract.methods.joinAGroup("0x1e884C988Fe944b1B87B472638477BFBE2be6237", 1)
                                                    .send({
                                                      from: this.state.accounts[0],
                                                      gas: 21000,
                                                      gasPrice: '20000000000'
                                                    })
                                                    .on("error", (err)=>{
                                                      console.log(err);
                                                    })
                                                    }><h1>Join a Group</h1></a>
                </div>
              </div>
              <div className="elekta_card card-color-third">
                <div className="elekta_card-content">
                <h1>Create a Community</h1>
                </div>
              </div>
              <div className="elekta_card card-color-fourth">
                <div className="elekta_card-content">
                <h1>Join a Community</h1>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </main>
    );
  }
}

export default App;
