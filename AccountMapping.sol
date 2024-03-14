// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AccountMapping {
    
    mapping(string => address) public userIdToAddress;
    
    event UserIdMapped(address indexed user, string userId);
    event UserIdUnmapped(address indexed user, string userId);

// UserId라는 string 값을 입력할 때 먼저 중복으로 있는지 require문을 통해 체크하고 매핑을 진행하는 과정    
    function mapUserId(string memory userId) public {
        require(userIdToAddress[userId] == address(0), "UserId already mapped");
        userIdToAddress[userId] = msg.sender;
        emit UserIdMapped(msg.sender, userId);
    }

// userId를 통해 매핑된 본인의 주소를 알 수 있는 기능을 하는 함수 
    function getUserAddress(string memory userId) public view returns(address) {
        return userIdToAddress[userId];
    }

// userId 매핑값을 지우는 함수 
    function unmapUserId(string memory userId) public {
        require(userIdToAddress[userId] == msg.sender, "You are not authorized to unmap this UserId");
        delete userIdToAddress[userId];
        emit UserIdUnmapped(msg.sender, userId);
    }
}

