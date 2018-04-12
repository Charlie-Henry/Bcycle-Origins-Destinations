
import csv
import pdb
# csvfile = open('trips_2017.csv', 'rb')
# read = csv.reader(csvfile, delimiter=',', quotechar='|')
tripdict ={}
index = 0;
with open('trips_2017.csv', 'r') as f:
	spamreader = csv.reader(f)
	for row in spamreader:
		if index >0:
			tripdict[row[0]] = row[5],row[7]
		index+=1

index = 0;
start_kiosks = {};
end_kiosks = {};
with open('kiosks.csv', 'r') as f:
	spamreader = csv.reader(f)
	for row in spamreader:
		if index >0:
			start_kiosks[row[0]] = 0
			end_kiosks[row[0]] = 0
		index+=1


for trip in tripdict:
	start_kiosks[tripdict[trip][0]] = start_kiosks[tripdict[trip][0]]+1
	end_kiosks[tripdict[trip][1]] = end_kiosks[tripdict[trip][1]]+1

trip_pairs = {}
for trip in tripdict:
	trip_pairs[str(tripdict[trip][0])+' '+ str(tripdict[trip][1])] = 0

for trip in tripdict:
	trip_pairs[str(tripdict[trip][0])+' '+str(tripdict[trip][1])] = trip_pairs[str(tripdict[trip][0])+' '+str(tripdict[trip][1])] + 1


for pair in trip_pairs:
	trip_pairs[pair]=trip_pairs[pair],pair[0:4],pair[5:]

with open('origins.csv', 'w') as csv_file:
    writer = csv.writer(csv_file)
    for key, value in start_kiosks.items():
       writer.writerow([key, value])

with open('destinations.csv', 'w') as csv_file:
    writer = csv.writer(csv_file)
    for key, value in end_kiosks.items():
       writer.writerow([key, value])

with open('pairs.csv', 'w') as csv_file:
    writer = csv.writer(csv_file)
    for key, value in trip_pairs.items():
       writer.writerow([value[1],value[2],value[0]])

