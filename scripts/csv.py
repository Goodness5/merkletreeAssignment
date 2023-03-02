import csv

data = [    ['0x5B38Da6a701c568545dCfcB03FcB875f56beddC4', 100],
    ['0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2', 200],
    ['0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c', 300],
    ['0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db', 400],
    ['0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB', 500],
    ['0x617F2E2fD72FD9D5503197092aC168c91465E7f2', 600],
    ['0x17F6AD8Ef982297579C203069C1DbfFE4348c372', 700],
    ['0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678', 800],
    ['0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7', 900],
    ['0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C', 1000]
]

with open('airdrop.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['address', 'amount'])
    writer.writerows(data)
