// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract product {
    struct productDetails {
        address manufacturer;
        uint ProductLicense;
        uint date;
        uint price;
        uint prodId;
        string pStatus;
    }

    mapping(uint => productDetails) public products;
    mapping(uint => bool) public vProducts;
    uint public nextId;

    // bytes32[] products;
    //bytes32[] owners;

    function registerProducts(
        uint ProductLicense,
        uint date,
        uint price,
        uint prodId
    ) external {
        require(!vProducts[prodId]);
        vProducts[prodId] = true;
        products[nextId] = productDetails(
            msg.sender,
            ProductLicense,
            date,
            price,
            prodId,
            "Available"
        );
        nextId++;
    }

    function sellProduct(uint sProductId) public {
        string memory status;
        uint i;
        uint j = 0;

        if (nextId != 0) {
            for (i = 0; i < nextId; i++) {
                if (products[i].prodId == sProductId) {
                    j = i;
                }
            }
        }

        status = products[j].pStatus;
        if (
            keccak256(abi.encodePacked(status)) ==
            keccak256(abi.encodePacked("Available"))
        ) {
            products[j].pStatus = "NA";
        }
    }

    function verifyFakeness(
        uint vProductId
    ) public view returns (productDetails memory, string memory) {
        bool status = false;
        uint i;
        uint j = 0;

        if (nextId != 0) {
            for (i = 0; i < nextId; i++) {
                if (products[i].prodId == vProductId) {
                    j = i;
                    status = true;
                }
            }
        }

        if (status == true) {
            if (
                keccak256(abi.encodePacked(products[j].pStatus)) ==
                keccak256(abi.encodePacked("Available"))
            ) return (products[j], "Original");
            else return (products[j], "Fake");
        } else {
            return (products[j], "Fake");
        }
    }
}
