#!/bin/bash
printf "\nIs not in the list... => "
curl -XGET http://localhost:10101/check?admin
printf "\nIs in the list! => "
curl -XGET http://localhost:10101/check-sha1?7FE890B89F8845387AD1B4377CAB1DAB0053682C
printf "\n\n"
