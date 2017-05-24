#todo: how do we handle this failing?
service act stop

cd /usr/local/act/
cp service.sh /etc/init.d/act
update-rc.d act defaults
service act start
