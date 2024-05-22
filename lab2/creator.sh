#/bin/bash

tasks=7

for (( i = 1; i <= 7; i++ )); do
	printf "#!/bin/bash\n\n" > "script$i.sh"
	chmod u+x script$i.sh
done 
