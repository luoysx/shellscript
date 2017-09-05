#!/bin/bash
## write by luoysx
## smokeping on centos6.7

## check root

if [ $UID != 0 ]
then 
   echo "you must be root"
   exit 1
fi
cd root
##关闭放火墙
setenforce 0
iptables -F

##安装依赖包和下载源码包
yum install -y perl perl-Net-Telnet perl-Net-DNS perl-LDAP perl-libwww-perl perl-IO-Socket-SSL perl-Socket6 perl-Time-HiRes perl-ExtUtils-MakeMaker rrdtool rrdtool-perl curl httpd httpd-devel gcc make wget libxml2-devel libpng-devel glib pango pango-devel freetype freetype-devel fontconfig cairo cairo-devel libart_lgpl libart_lgpl-devel popt popt-devel libidn libidn-devel 
wget https://raw.githubusercontent.com/luoysx/local/master/echoping-6.0.2.tar.gz
wget https://raw.githubusercontent.com/luoysx/local/master/fping-3.10.tar.gz
wget https://raw.githubusercontent.com/luoysx/local/master/smokeping-2.6.9.tar.gz

##安装fping
tar xf fping-3.10.tar.gz
cd fping-3.10
./configure
make && make install
cd

##安装echoping
tar xf echoping-6.0.2.tar.gz
cd echoping-6.0.2
./configure
make && make install
cd

##安装smokeping
tar xf smokeping-2.6.9.tar.gz
cd smokeping-2.6.9
./setup/build-perl-modules.sh /usr/local/smokeping/thirdparty
./configure --prefix=/usr/local/smokeping
/usr/bin/gmake install
cd

##配置smokeping
cd /usr/local/smokeping/
mkdir cache data var
touch /var/log/smokeping.log
chown apache:apache cache data var
chown apache:apache /var/log/smokeping.log
chmod 600 /usr/local/smokeping/etc/smokeping_secrets.dist
cd /usr/local/smokeping/htdocs
mv smokeping.fcgi.dist smokeping.fcgi
cd /usr/local/smokeping/etc
mv config.dist config
cd

##更改配置文件
ip=`ip addr |grep  'global eth0' |cut -d/ -f1|cut -d' ' -f6` 
cat /usr/local/smokeping/etc/config|sed -i 's/some.url/$ip/g'

##编辑apache文件
echo Alias /cache "/usr/local/smokeping/cache/" >>/etc/httpd/conf/httpd.conf
echo Alias /cropper "/usr/local/smokeping/htdocs/cropper/" >>/etc/httpd/conf/httpd.conf
echo Alias /smokeping "/usr/local/smokeping/htdocs/smokeping.fcgi" >>/etc/httpd/conf/httpd.conf
echo '<Directory "/usr/local/smokeping">' >>/etc/httpd/conf/httpd.conf
echo AllowOverride None >>/etc/httpd/conf/httpd.conf
echo Options All >>/etc/httpd/conf/httpd.conf
echo AddHandler cgi-script .fcgi .cgi >>/etc/httpd/conf/httpd.conf
echo Order allow,deny >>/etc/httpd/conf/httpd.conf
echo Allow from all >>/etc/httpd/conf/httpd.conf
echo DirectoryIndex smokeping.fcgi >>/etc/httpd/conf/httpd.conf
echo '</Directory>' >>/etc/httpd/conf/httpd.conf
##中文支持
yum -y install wqy-zenhei-fonts.noarch
sed -i -e  "/template/a charset = utf-8" /usr/local/smokeping/etc/config

##修改fping
sed -i 's/\/sbin\/fping/\/local\/sbin\/fping/g' /usr/local/smokeping/etc/config
##添加测试IP
wget https://raw.githubusercontent.com/luoysx/shellscript/master/testip.txt
cat testip.txt>>/usr/local/smokeping/etc/config
##启动apache和smokeping&设置环境变量
/etc/init.d/httpd start
/usr/local/smokeping/bin/smokeping

echo 'export PATH=/usr/local/smokeping/bin/:$PATH' >> /etc/profile
