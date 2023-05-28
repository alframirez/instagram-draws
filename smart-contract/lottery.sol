// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract MyContract {
    string[] private myArray;
    string private winner_1;
    string private winner_2;
    string private winner_3;

event WinnersSelected(string winner1, string winner2, string winner3);

    function setWinners(string memory _winner1, string memory _winner2, string memory _winner3) private {
    winner_1 = _winner1;
    winner_2 = _winner2;
    winner_3 = _winner3;

     emit WinnersSelected(winner_1, winner_2, winner_3);
    }

    function getWinner1() public view returns (string memory) {
        return winner_1;
    }

    function getWinner2() public view returns (string memory) {
        return winner_2;
    }

    function getWinner3() public view returns (string memory) {
        return winner_3;
    }

    function setMyArray(string[] memory _myArray) public {
        myArray = _myArray;
    }

function getRandomString() public {
    require(myArray.length >= 3, "Array must have at least 3 strings");

    uint[] memory indices = new uint[](myArray.length);
    for (uint i = 0; i < indices.length; i++) {
        indices[i] = i;
    }

    for (uint i = 0; i < 3; i++) {
        require(myArray.length > 0, "Not enough myArray to choose from");
        uint index = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, i))) % myArray.length;
        if (i == 0) {
            winner_1 = myArray[index];
        } else if (i == 1) {
            winner_2 = myArray[index];
        } else {
            winner_3 = myArray[index];
        }
        myArray[index] = myArray[myArray.length - 1];
        myArray.pop();
    }

require(keccak256(abi.encodePacked(winner_1)) != keccak256(abi.encodePacked(winner_2)) &&
        keccak256(abi.encodePacked(winner_1)) != keccak256(abi.encodePacked(winner_3)) &&
        keccak256(abi.encodePacked(winner_2)) != keccak256(abi.encodePacked(winner_3)),
        "Winners cannot be the same");

        setWinners(winner_1, winner_2, winner_3);
        
}

}
