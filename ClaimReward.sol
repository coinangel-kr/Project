// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract TokenReward is Ownable, ReentrancyGuard {
    IERC20 public rewardsToken;

    event RewardClaimed(address indexed user, uint amount);

// _rewardsToken에는 보상으로 주려는 Token Contract address, _initialOwner에는 해당 시스템의 관리자 주소를 넣어서 Deploy 
    constructor(address _rewardsToken, address _initialOwner) Ownable(_initialOwner) {
        rewardsToken = IERC20(_rewardsToken);
    }

// 100개의 토큰을 보상(10**18은 Token decimal)
    function claimRewardforBloodTest() public nonReentrant { 
        uint RewardAmountforBloodTest = 100*10**18;
        rewardsToken.transfer(msg.sender, RewardAmountforBloodTest);
        emit RewardClaimed(msg.sender, RewardAmountforBloodTest);
    }

// 500개의 토큰을 보상(10**18은 Token decimal)
    function claimRewardforCancerDiagnosis() public nonReentrant { 
        uint RewardAmountforCancerDiagnosis = 500*10**18;
        rewardsToken.transfer(msg.sender, RewardAmountforCancerDiagnosis);
        emit RewardClaimed(msg.sender, RewardAmountforCancerDiagnosis);
    }

}


// ReentrancyGuard 컨트랙트를 import하여 nonReentrant 모디파이어 사용 >> 보상을 클레임하는 함수에서 reentrancy 공격 방지 

