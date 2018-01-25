read -p "[1] Listen Port (7777) > " lport
read -p "[2] Your Domain (localhost) > " domain
read -p "[3] Pool Host&Port (pool.cryptonoter.com:1111) > " pool
read -p "[4] Your XMR /ETN / BCN wallet (Important) > " addr
if [ ! -n "$lport" ];then
    lport="7777"
fi
if [ ! -n "$domain" ];then
    domain="localhost"
fi
if [ ! -n "$pool" ];then
    pool="pool.cryptonoter.com:1111"
fi
while  [ ! -n "$addr" ];do
    read -p "Plesae set XMR /ETN / BCN wallet address! > " addr
done
read -p "[5] The Pool passwd (null) > " pass
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt install --yes nodejs git curl
mkdir /srv
cd /srv
rm -rf CryptoNoter
git clone https://github.com/cryptonoter/CryptoNoter.git -o CryptoNoter
cd CryptoNoter
npm update
npm install -g forever
npm install -g ws
forever start /srv/CryptoNoter/server.js
sed -i '/forever start \/srv\/CryptoNoter\/server.js/d' /etc/rc.local
sed -i '/exit 0/d' /etc/rc.local
echo "forever start /srv/CryptoNoter/server.js" >> /etc/rc.local
echo "exit 0" >> /etc/rc.localclear
echo " >>> Serv : $domain (backend > 127.0.0.1:$lport)"
echo " >>> Pool : $pool"
echo " >>> Addr : $addr"
echo ""
echo " Installation Completed ! Start Mining Using CryptoNoter !"
echo ""
