import csv

with open("airdrop.csv", 'r') as file:
  csvreader = csv.reader(file)
  for row in csvreader:
    print(row)