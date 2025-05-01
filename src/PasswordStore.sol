// SPDX-License-Identifier: MIT
pragma solidity 0.8.24; 

contract PasswordStore {
    error PasswordStore__NotOwner();
/*//////////////////////////////////////////////////////////////                   
          STATE VARIABLES
    //////////////////////////////////////////////////////////////*/


    address private s_owner;
    // @audit the s_password variable is not actully pricate!, this is not a secure place to store your password.
    string private s_password;
    /*//////////////////////////////////////////////////////////////                            
            EVENTS
    //////////////////////////////////////////////////////////////*/

    event SetNewPassword(); 

    constructor() {
        s_owner = msg.sender;
    }

    /*
     * @notice Allows the owner to set a new password.
     * @param newPassword The new password to store.
     */


     //Q can a none owner set a password?
     //Q should a non-owner be able to set a passord?
     //@audit any user can set a password
     // missing access control
    function setPassword(string memory newPassword) external {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        s_password = newPassword;
        emit SetNewPassword();
    }

    /*
     * @notice Allows the owner to retrieve the stored password.
     
     */
     // theres no new password parameter

    function getPassword() external view returns (string memory) {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
}