// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract RealestateToken is ERC1155 {

    mapping(uint256 => string) private _tokenURIs;
    
    constructor() ERC1155("https://ipfs.io/ipfs/...") {} 

    function mint(address account, uint256 id, uint256 amount, bytes memory data) public {
        _mint(account, id, amount, data);
    }

    function setTokenURI(uint256 tokenId, string memory newURI) public {
        require(bytes(newURI).length > 0, "URI should not be empty");
        _tokenURIs[tokenId] = newURI;
        emit URI(newURI, tokenId);
    }





