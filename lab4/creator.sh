#!/bin/bash

for (( i = 1; i <= 4; ++i )); do
	printf "#!/bin/bash\n\n\n" > script$i.sh
	chmod u+x script$i.sh
done

