### [H-1] Storing the password on-chain makes it visible and no longer private

**Description:**  
All data stored on-chain is publicly visible. Anyone can read it directly from the blockchain. The `PasswordStore::s_password` variable is meant to be private and accessed only through the `PasswordStore::getPassword` function, which is intended to be called only by the contract owner.

Here’s one method of reading such data off-chain:

**Impact:**  
Anyone can read the private password, which breaks the intended functionality of the protocol.

**Proof of Concept:**  
The following test case demonstrates how the password can be read directly from the blockchain:

1. Start a local chain:
   ```bash
   make anvil
   ```

2. Deploy the contract:
   ```bash
   make deploy
   ```

3. Read the password using the storage slot.  
   We use slot `1`, assuming that's where `s_password` is stored:
   ```bash
   cast storage <ADDRESS_HERE> 1 --rpc-url http://127.0.0.1:8545
   ```

   This returns:
   ```
   0x6d7950617373776f726400000000000000000000000000000000000000000014
   ```

   Decode it using:
   ```bash
   cast parse-bytes32-string 0x6d7950617373776f726400000000000000000000000000000000000000000014
   ```

   Output:
   ```
   myPassword
   ```

**Recommended Mitigation:**  
The contract architecture needs a redesign. One option is to encrypt the password off-chain and store only the encrypted result on-chain. This would require users to manage a decryption key off-chain. Additionally, remove the `view` function to prevent users from accidentally submitting transactions containing the decryption key.

---



## LikelyHood  $ impact
- Impact : High
- LikelyHod: High
- severity: High

## high
-worst offenders --> least bad


### [H-2] `PasswordStore::setPassword` lacks access control—non-owners can change the password

**Description:**  
The `PasswordStore::setPassword` function is marked `external`, but its NatSpec comment implies that only the owner should call it. There is no actual access control in place.

```solidity
function setPassword(string memory newPassword) external {
    //@audit - no access controls present
    s_password = newPassword;
    emit SetNetPassword();
}
```

**Impact:**  
Anyone can change the contract’s password, which completely breaks the intended behavior.

**Proof of Concept:**  
Add the following to `passwordStore.t.sol`:

<details>
<summary>Code</summary>

```solidity
function test_anyone_can_set_password() public {
    address randomAddress = vm.addr(1);
    vm.assume(randomAddress != owner);
    vm.prank(randomAddress);

    string memory expectedPassword = "myNewPassword";
    passwordStore.setPassword(expectedPassword);
    string memory actualPassword = passwordStore.getPassword();

    assertEq(actualPassword, expectedPassword);
}
```
</details>

**Recommended Mitigation:**  
Add an access control check to `setPassword`:

```solidity
if (msg.sender != s_owner) {
    revert PasswordStore_NotOwner();
}
```

---

### [I-1] Incorrect NatSpec for `PasswordStore::getPassword` showing that a parameter doesnt exist.

**Description:**  
```solidity
/**
 * @notice This allows only the owner to retrieve the password.
 * @param newPassword The new password doesn't exist.
 */
function getPassword() external view returns (string memory) {}
```

The function does not take any parameters, but the NatSpec includes a `@param` line for a nonexistent `newPassword`.

**Impact:**  
The NatSpec is incorrect and may mislead users or automated documentation tools.

**Recommended Mitigation:**  
Remove the incorrect NatSpec line:

```diff
- * @param newPassword The new password to set.
```

---
