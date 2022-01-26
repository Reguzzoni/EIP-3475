// SPDX-License-Identifier: MIT


pragma solidity ^0.6.8;

import "./IERC3475.sol";
import "./ERC3475data.sol";

contract ERC3475 is IERC3475, ERC3475data {

    function totalSupply(uint256 class, uint256 nonce) public override view returns (uint256) {

        return _activeSupply[class][nonce] + _burnedSupply[class][nonce] + _redeemedSupply[class][nonce];
    }

    function activeSupply(uint256 class, uint256 nonce) public override view returns (uint256) {

        return _activeSupply[class][nonce];
    }

    function burnedSupply(uint256 class, uint256 nonce) public override view returns (uint256) {

        return _burnedSupply[class][nonce];
    }

    function redeemedSupply(uint256 class, uint256 nonce) public override view returns (uint256) {

        return _redeemedSupply[class][nonce];
    }

    function balanceOf(address account, uint256 class, uint256 nonce) public override view returns (uint256){
        require(account != address(0), "ERC659: balance query for the zero address");

        return _balances[account][class][nonce];
    }

    function balanceOf(address account, uint256 class, uint256 nonce) public override view returns (uint256){
        require(account != address(0), "ERC659: balance query for the zero address");
        return _balances[account][class][nonce];
    }

    function getBondSymbol(uint256 class) view public override returns (string memory){

        return _Symbol[class];
    }

    function getBondInfo(uint256 class, uint256 nonce) public view override returns (string memory bondSymbol, uint256 timestamp, uint256 info2, uint256 info3, uint256 info4, uint256 info5, uint256 info6) {
        bondSymbol = _Symbol[class];
        timestamp = _nonceInfo[class][nonce][1];
        info2 = _nonceInfo[class][nonce][2];
        info3 = _nonceInfo[class][nonce][3];
        info4 = _nonceInfo[class][nonce][4];
        info5 = _nonceInfo[class][nonce][5];
        info6 = _nonceInfo[class][nonce][6];
    }

    function bondIsRedeemable(uint256 class, uint256 nonce) public override view returns (bool) { // TODO we need to know the domain of that function, if it is general

        if(uint(_nonceInfo[class][nonce][1])<now){
            uint256 total_liquidity;
            uint256 needed_liquidity;
            //uint256 available_liquidity;

            for (uint i=0; i<=last_bond_nonce[class]; i++) {
                total_liquidity += _activeSupply[class][i]+_redeemedSupply[class][i];
            }

            for (uint i=0; i<=nonce; i++) {
                needed_liquidity += (_activeSupply[class][i]+_redeemedSupply[class][i])*2;
            }

            if(total_liquidity>=needed_liquidity){

                return(true);

            }

            else{
                return(false);
            }
        }

        else{
            return(false);
        }


    }

}