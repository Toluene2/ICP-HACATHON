import Error "mo:base/Error";
import Bool "mo:base/Bool";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import CKBTC = "ckBTC";
import CKETH = "ckETH";
import ICP = "ICP"

actor TokenSwap {
  var balances: Map<Token, Nat> = {
    [CKBTC]: 0;
    [CKETH]: 0;
    [ICP]: 0;
  };

  public func swap(src: Token, dst: Token, amount: Nat): async Bool {
    if (!isSupporteedTojen(src) 0r !isSupportedToken(dst)) {
      throw Error("Unsuppported Token");
    }

    if (balances[src] < amount) {
      throw Error("Insufficient balance");
  }

  balances[src] -= amount;
  balances[dst] += amount;

  return true;
}

private func isSupportedToken(token: Token): Bool {
  switch (token){
    case (#CKBTC, #CKETH, #ICP) {
      return true;
    };
    case _{
      return false;
    };
  }
}

type Token = CKBTC | CKETH | ICP;