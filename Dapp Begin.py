from web3 import Web3


gnache_url = "HTTP://127.0.0.1:7545"
web3 = Web3(Web3.HTTPProvider(gnache_url))

print(web3.isConnected())

account1 = "0x9D7700325246447A5e481f355167637e1a2f2a0A"
account2 = "0x3F764C22F69Da4754b16796cD4D2e5383FE43a5e"

private_key = "9aa34d6f42d04aa53146cdbba11a3e7e45d10971ae5b2bc49683d64b21cfa2b1"

#building the transaction
balance1 = web3.eth.get_balance(account1)
print(balance1)
nonce = web3.eth.get_transaction_count(account1)
transaction_info = {
    'nonce': 0,
    'to': account2,
    'value': web3.toWei(1, 'ether'),
    'gas': 2000000,
    'gasPrice': web3.toWei('50','gwei')
}

signed_transaction = web3.eth.account.signTransaction(transaction_info,private_key)

#print(signed_transaction)
transaction_hash = web3.eth.send_raw_transaction(signed_transaction.rawTransaction)
print(transaction_hash)