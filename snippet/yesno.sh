#!/bin/bash

# yes/no question [http://stackoverflow.com/questions/226703]
while true; do
        read -rp "yes or no? "
        case $REPLY in
                [Yy] | [Yy][Ee][Ss])
                        break
                        ;;
                [Nn] | [Nn][Oo])
                        break
                        ;;
                *)
			echo "Answer yes or no."
                        ;;
        esac
done

