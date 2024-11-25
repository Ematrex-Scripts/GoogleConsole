
sudo apt install git  -y

git clone https://github.com/Ematrex-Scripts/GoogleConsole.git

cd GoogleConsole && chmod 777 * 

bash postfix.sh 

nohup python3 main.py $1   $2 > output.log 2>&1 &
