#!/bin/bash

tasks=7

for (( i = 1; i <= tasks; ++i )); do
	touch "script_$i.sh"
	printf "#!/bin/bash\n\n" > "script_$i.sh"
	chmod u+x "script_$i.sh"
done
