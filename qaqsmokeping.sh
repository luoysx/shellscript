#!/bin/bash
## write by luoysx
## smokeping on centos7.2

## check root

if [ $UID != 0 ]
then 
   echo "you must be root"
   exit 1
fi
cd /root
##替换yum源
wget https://raw.githubusercontent.com/luoysx/shellscript/master/yum.txt
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
mv yum.txt /etc/yum.repos.d/CentOS-Base.repo
yum install net-tools

##关闭放火墙
setenforce 0
systemctl stop firewalld.service

##时间同步
yum install ntpdate -y
ntpdate times.aliyun.com

##安装依赖
yum groupinstall "Compatibility libraries" "Base" "Development tools" -y
yum install -y perl perl-Net-Telnet perl-Net-DNS perl-LDAP perl-libwww-perl perl-IO-Socket-SSL perl-Socket6 perl-Time-HiRes perl-ExtUtils-MakeMaker rrdtool rrdtool-perl curl  httpd httpd-devel gcc make  wget libxml2-devel libpng-devel glib pango pango-devel freetype freetype-devel fontconfig cairo cairo-devel libart_lgpl libart_lgpl-devel perl-CGI-SpeedyCGI perl-Sys-Syslog popt-devel libidn-devel fping

##安装smokeping
wget https://raw.githubusercontent.com/luoysx/local/master/smokeping-2.6.9.tar.gz
tar xvf smokeping-2.6.9.tar.gz
cd smokeping-2.6.9
./setup/build-perl-modules.sh /usr/local/smokeping/thirdparty
./configure --prefix=/usr/local/smokeping
/usr/bin/gmake install
/usr/bin/gmake install
cd

##安装fping
wget https://raw.githubusercontent.com/luoysx/local/master/fping-3.10.tar.gz
tar xvf fping-3.10.tar.gz
cd fping-3.10
./configure
make && make install
cd

##配置修改
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

##apache修改
sed -i 's#\/var\/www#\/usr\/local\/smokeping#g' /etc/httpd/conf/httpd.conf
echo 'Alias /cache "/usr/local/smokeping/cache/"' >>/etc/httpd/conf.d/somekping.conf 
echo 'Alias /cropper "/usr/local/smokeping/htdocs/cropper/"' >>/etc/httpd/conf.d/somekping.conf
echo 'Alias /smokeping "/usr/local/smokeping/htdocs/smokeping.fcgi"' >>/etc/httpd/conf.d/somekping.conf
echo '<Directory "/usr/local/smokeping">' >>/etc/httpd/conf.d/somekping.conf
echo 'AllowOverride None' >>/etc/httpd/conf.d/somekping.conf
echo 'Options All' >>/etc/httpd/conf.d/somekping.conf
echo 'AddHandler cgi-script .fcgi .cgi' >>/etc/httpd/conf.d/somekping.conf
echo 'Order allow,deny' >>  /etc/httpd/conf.d/somekping.conf
echo 'Allow from all' >>  /etc/httpd/conf.d/somekping.conf
echo 'DirectoryIndex smokeping.fcgi' >> /etc/httpd/conf.d/somekping.conf
echo '</Directory>' >> /etc/httpd/conf.d/somekping.conf
systemctl restart httpd

ip=`ip addr |grep  'global eth0' |cut -d/ -f1|cut -d' ' -f6` 
cat /usr/local/smokeping/etc/config|sed -i 's/some.url/$ip/g'
cat /usr/local/smokeping/etc/config|sed -i 's/300/60/g'
wget https://raw.githubusercontent.com/luoysx/shellscript/master/testip.txt
cat testip.txt>>/usr/local/smokeping/etc/config

##修改字符集
sed -i -e  "/Presentation/a charset = utf-8" /usr/local/smokeping/etc/config
yum -y install wqy-zenhei-fonts
#sed -i -e "/'--end', $tasks[0][2],/a '--font TITLE:20""'" /usr/local/smokeping//lib/Smokeping/Graphs.pm

/usr/local/smokeping/bin/smokeping restart
