import csv
from prettytable import PrettyTable

data = [    ['0x2bea82919980E15B2528f42a40829D7294E239c6', 1000],
    ['0x87d37b9B303b4b0F23cc7420b8431Fdd5FA17e62', 1000],
    ['0xa4eD5f14F0BE23465dfD4AC01E3b0f6AA5515EA1', 1000],
    ['0xF4387F4ffD3DF6fE3F582e23c53418966043eAB2', 1000],
    ['0xC94eBB328aC25b95DB0E0AA968371885Fa516215', 1000],
    ['0x54d961fe5fadD14275F3E1e3b85cd95202b0c6E0', 1000],
    ['0x9AA65464b4cFbe3Dc2BDB3dF412AeE2B3De86687', 1000],
    ['0x1e53A50A0B40C9E402B8438f1feFB47ac4036bd1', 1000],
    ['0xC992881E4f8F5B3aBa761E6d5ef3A5F36CadCcff', 1000],
    ['0x1990bBC7bF55Ca3836910Bb8064AF5AEA1aa3990', 1000]
]


table = PrettyTable()
table.field_names = ["Address", "Amount"]
for row in data:
    table.add_row(row)

with open("formatted_data.csv", "w", newline="") as csvfile:
    csvfile.write(table.get_csv_string())

