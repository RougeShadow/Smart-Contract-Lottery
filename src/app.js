var Web3 = require("web3")
var $ = require("jquery")
console.log("Logs working")
var contract = require("@truffle/contract");
var mnemonic = "hover danger amused inject work crystal impose narrow lock twelve close section"
 async function Load() {
   try{
  await LoadContract()
  console.log("App loaded")
   }
   catch(error){
   }
  }
async () => {
    try {
      const provider = await detectEthereumProvider();

      if (provider) {
        // From now on, this should always be true:
        // provider === window.ethereum
        startApp(provider); // initialize your app
      } else {
        console.log('Please install MetaMask!');
      }
    } catch (error) {
      
    }

}


function startApp(provider) {
  // If the provider returned by detectEthereumProvider is not the same as
  // window.ethereum, something is overwriting it, perhaps another wallet.
  if (provider !== window.ethereum) {
    console.error('Do you have multiple wallets installed?');
  }
  // Access the decentralized web!
}
if (typeof window.ethereum !== 'undefined') {
    console.log('MetaMask is installed!');
  }

function getAccounts(callback) {
  web3.eth.getAccounts((error,result) => {
      if (error) {
          console.log(error);
      } else {
          callback(result);
      }
  });
}
const ethereumButton = document.querySelector('#ConnectButton');
ethereumButton.addEventListener('click', () => {
  //Will Start the metamask extension
  console.log("you are already logged in")
  ethereum.request({ method: 'eth_requestAccounts' });
  getAccounts(function(result) {
    console.log(result[0]);
    document.getElementById("ConnectText").innerHTML =(result[0]);
});
});
window.addEventListener('load', async () => {
    // Modern dapp browsers...
    if (window.ethereum) {
        window.web3 = new Web3(ethereum);
        try {
            ethereum.request({ method: 'eth_requestAccounts' });
            // Request account access if needed
            await ethereum.request({ method: 'eth_requestAccounts' });
            // Acccounts now exposed
            web3.eth.sendTransaction({/* ... */});
        } catch (error) {
            // User denied account access...
        }

    }
    // Legacy dapp browsers...
    else if (window.web3) {
        window.web3 = new Web3(web3.currentProvider);
        // Acccounts always exposed
        web3.eth.sendTransaction({/* ... */});
    }
    // Non-dapp browsers...
    else {
        console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
    }
}); 
  async function LoadContract() {
    
    try{
  console.log("contracts loaded...")
  LotteryContract = await $.getJSON("LotteryContract.json")
  console.log(LotteryContract);
  TruffleLotteryContract = contract(LotteryContract)
  TruffleLotteryContract.setProvider(web3.currentProvider)
  LotteryContract = await TruffleLotteryContract.deployed()
  console.log(LotteryContract)
  
  
    }
    catch(error){
    }
}

  const ticketButton = document.querySelector('#TicketGen');
  ticketButton.addEventListener('click', () => {
  getAccounts(function(result) {
  console.log(result[0]);
  LotteryContract.TicketGen({from: result[0],value:Web3.utils.toWei("0.01")}) 
  console.log("Ticket Generated")
});
});

$(function() {
  $(document).on('keyup', 'input', function() {
      tickets=$(this).val()
      console.log(tickets)
      price=(tickets*0.01)
      console.log(price)
      document.getElementById("Price").innerHTML =(price + "ETH");
      })
  });


$(()=> {
    Load()
    console.log("loader called")
  })  

