// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract RewardHealthcare is  Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, ERC20PermitUpgradeable,  OwnableUpgradeable, UUPSUpgradeable {

    constructor() {
        _disableInitializers();
    }

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    function initialize(address initialOwner) initializer public {
        __ERC20_init("RewardHealthcare", "RH");
        __ERC20Burnable_init();
        __Ownable_init(initialOwner);
        __ERC20Permit_init("RewardHealthcare");
        __UUPSUpgradeable_init();
        _mint(_msgSender(), 100000000 * 10 ** decimals());
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
    
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool) {
        require(_from != address(0), "Invalid address");
        require(_to != address(0), "Invalid address");
        require(_value <= balances[_from], "Insufficient balance");
        require(_value <= allowed[_from][_msgSender()], "Allowance exceeded");
        
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][_msgSender()] -= _value;
        
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public override returns (bool) {
        allowed[_msgSender()][_spender] = _value;
        emit Approval(_msgSender(), _spender, _value);
        return true;
    }

        function _update(address from, address to, uint256 value)
        internal
        override(ERC20Upgradeable)
    {
        super._update(from, to, value);
    }
}
