domain ="$1"
from_email ="$2"

unzip // clone

mkdir -p Send && cd Send


chmod +x postfix.sh send.sh

bash postfix.sh 

nohup python3 main.py $domain   $from_email > output.log 2>&1 &
