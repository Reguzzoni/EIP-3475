// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;


interface IERC3475 {

    /**
     * @dev Returns the total supply of the bond in question
     */
    function totalSupply(bytes32 classId, bytes32 nonceId) external view returns (uint256);

    /**
     * @dev Returns the redeemed supply of the bond in question
     */
    function redeemedSupply(bytes32 classId, bytes32 nonceId) external view returns (uint256);

    /**
     * @dev Returns the active supply of the bond in question
     */
    function activeSupply(bytes32 classId, bytes32 nonceId) external view returns (uint256);

    /**
     * @dev Returns the burned supply of the bond in question
     */
    function burnedSupply(bytes32 classId, bytes32 nonceId) external view returns (uint256);

    /**
     * @dev Returns the balance of the giving bond classId and bond nonce
     */
    function balanceOf(address account, bytes32 classId, bytes32 nonceId) external view returns (uint256);

    /**
     * @dev Returns the bond symbol and a list of uint256 parameters of a bond nonce.
      * — e.g. ["DEBIT-BUSD","1615584000",(3rd uint256)...].** Every bond contract can have their own list.
      * But the first uint256 in the list MUST be the UTC time code of the issuing time.
     */
    function infos(bytes32 classId, bytes32 nonceId) external view returns (string memory _symbol, uint256 startingDate, uint256 maturityDate, uint256 info3, uint256 info4, uint256 info5, uint256 info6);

    function transferFrom(address _from, address _to, bytes32 classId, bytes32 nonceId, uint256 _amount) external;

    function issue(address to, bytes32 classId, uint256 startingTime, uint256 maturityTime, uint256 amount) external;

    function redeem(address _from, bytes32 classId, bytes32 nonceId, uint256 _amount) external;

    function burn(address _from, bytes32 classId, bytes32 nonceId, uint256 _amount) external;

    function isRedeemable(bytes32 classId, bytes32 nonceId) external view returns (bool);

    function isApprovedFor(address account, address operator, bytes32 classId, bytes32 nonceId) external view returns (bool);

    function batchIsApprovedFor(address account, address operator, bytes32[] calldata classIds, bytes32[] calldata nonceIds) external view returns (bool);

    /**
     * @dev Transfer of any number of bond types from an address to another.
     */
    function batchTransferFrom(address _from, address _to, bytes32[] calldata classIds, bytes32[] calldata nonceIds, uint256[] calldata _amount) external;

    /**
        @notice Enable or disable approval for a third party ("operator") to manage a given bond.
        @dev MUST emit the ApprovalFor event on success.
    */
    function setApprovalFor(address _operator, bytes32[] calldata classIds, bytes32[] calldata nonceIds, bool _approved) external;

    /**
        @dev Either `TransferSingle` or `TransferBatch` MUST emit when tokens are transferred, including zero value transfers as well as minting or burning (see "Safe Transfer Rules" section of the standard).
        The `_operator` argument MUST be the address of an account/contract that is approved to make the transfer (SHOULD be msg.sender).
        The `_from` argument MUST be the address of the holder whose balance is decreased.
        The `_to` argument MUST be the address of the recipient whose balance is increased.
        The `_classId` argument MUST be the classId of the token being transferred.
        The `_nonceId` argument MUST be the nonce of the token being transferred.
        The `_amount` argument MUST be the number of tokens the holder balance is decreased by and match what the recipient balance is increased by.
        When minting/creating tokens, the `_from` argument MUST be set to `0x0` (i.e. zero address).
        When burning/destroying tokens, the `_to` argument MUST be set to `0x0` (i.e. zero address).
    */
    event Transfer(address indexed _operator, address indexed _from, address indexed _to, bytes32 classId, bytes32 nonceId, uint256 _amount);

    event Redeem(address indexed _operator, address indexed _from, bytes32 classId, bytes32 nonceId, uint256 _amount);

    event Burn(address indexed _operator, address indexed _from, bytes32 classId, bytes32 nonceId, uint256 _amount);

    event Issue(address indexed _operator, address indexed _to, bytes32 classId, bytes32 nonceId, uint256 _amount);


    /**
        @dev Either `TransferSingle` or `TransferBatch` MUST emit when tokens are transferred, including zero value transfers as well as minting or burning (see "Safe Transfer Rules" section of the standard).
    */
    event TransferBatch(address indexed _operator, address indexed _from, address indexed _to, bytes32[] classIds, bytes32[] nonceIds, uint256[] _amounts);

    /**
        @dev MUST emit when approval for a second party/operator address to manage all tokens for an owner address is enabled or disabled (absence of an event assumes disabled).
    */
    event ApprovalFor(address indexed _owner, address indexed _operator, bytes32[] classIds, bytes32[] nonceIds, bool _approved);

}