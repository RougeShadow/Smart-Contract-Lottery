pragma solidity ^ 0.8.4;
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
contract testContract{
    enum state {Standby,Ready,Deployed}
    string[3] ListState = ["Standby","Ready","Deployed"];
    uint256 stateNum;
    mapping (address => string[]) public addr;
    address owner;
    address[] public addreses;
    bool ticketCheck;
    uint256 public userCount = 0;
    address payable recipient = 0x495357714631f60353b65d12e57B7Aa8b9d34679 ;
    constructor() public {
    state.Standby;
    owner = msg.sender;


    }
    function userAdd() public {
        userCount ++;
        addreses.push(msg.sender);
    }
    function TicketGen() public payable returns(address) {
        if (msg.value == 50) {
            ticketCheck = true;
            userAdd();
            state.Deployed;
        }
        require(ticketCheck = true);
        userCountView();
        recipient.transfer(49 wei);
        return (msg.sender);
    }
    function userCountView() public view returns (uint256 UserNumber) {
        UserNumber = userCount;
        return UserNumber;
    }
    modifier adminCheck() {
        require(msg.sender == owner);
        _;
    }
    function addAddr(string memory adress1) public {
        addr[payable(msg.sender)].push(adress1);
    }
    function Ready() public{
        state.Ready;
        stateNum = 1;
    }
    function Deploy() public{
        stateNum = 2;
        state.Deployed;

    }
    function isState() public view returns (string memory){
        if(stateNum == 0){
            return ListState[stateNum];
        }
            else{
                 return ListState[stateNum];
        }

    }
}
contract RandomNumberConsumer is VRFConsumerBase{

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;

    /**
     * Constructor inherits VRFConsumerBase
     *
     * Network: Kovan
     * Chainlink VRF Coordinator address: 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9
     * LINK token address:                0xa36085F69e2889c224210F603D836748e7dC0088
     * Key Hash: 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4
     */
    constructor()
        VRFConsumerBase(
            0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9, // VRF Coordinator
            0xa36085F69e2889c224210F603D836748e7dC0088  // LINK Token
        ) public
    {
        keyHash = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;
        fee = 0.1 * 10 ** 18; // 0.1 LINK
    }

    /**
     * Requests randomness from a user-provided seed
     ************************************************************************************
     *                                    STOP!                                         *
     *         THIS FUNCTION WILL FAIL IF THIS CONTRACT DOES NOT OWN LINK               *
     *         ----------------------------------------------------------               *
     *         Learn how to obtain testnet LINK and fund this contract:                 *
     *         ------- https://docs.chain.link/docs/acquire-link --------               *
     *         ---- https://docs.chain.link/docs/fund-your-contract -----               *
     *                                                                                  *
     ************************************************************************************/
    function getRandomNumber(uint256 userProvidedSeed) public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
        return requestRandomness(keyHash, fee, userProvidedSeed);
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;

    }

    /**
     * Withdraw LINK from this contract
     *
     * DO NOT USE THIS IN PRODUCTION AS IT CAN BE CALLED BY ANY ADDRESS.
     * THIS IS PURELY FOR EXAMPLE PURPOSES.
     */
    function randUseCount(testContract UseNum) public returns (uint){
        randomResult = randomResult % (UseNum.userCountView());
        return (randomResult);

    }
    function viewRand() public view returns(uint) {
        return randomResult;
    }

    function withdrawLink() external {
        require(LINK.transfer(msg.sender, LINK.balanceOf(address(this))), "Unable to transfer");
    }

}