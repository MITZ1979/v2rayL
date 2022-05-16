#!/bin/bash
# author: Suummmmer

echo "创建   /etc/v2rayL"
if [ -d "/etc/v2rayL" ];then
    echo "已存在/etc/v2rayL"
else
    sudo mkdir /etc/v2rayL
    echo "设置权限和快捷方式"
    sudo chmod 777 -R /etc/v2rayL
fi

echo "创建   /usr/bin/v2rayL"
if [ -d "/usr/bin/v2rayL" ];then
    echo "已存在/usr/bin/v2rayL"
else
    sudo mkdir /usr/bin/v2rayL
    sudo chmod 777 -R /usr/bin/v2rayL
fi
echo "正在下载内核文件"
wget -P /etc/v2rayL http://cloud.thinker.ink/download/v2ray-core.tar
cd /etc/v2rayL
tar -xvf v2ray-core.tar
sudo cp /etc/v2rayL/v2ray-core/{geoip.dat,geosite.dat,v2ctl,v2ray,v2ray.sig,v2ctl.sig} /usr/bin/v2rayL
echo "正在下载service文件"
sudo cp /etc/v2rayL/v2ray-core/v2rayL.service /etc/systemd/system/

echo "判断静态文件夹是否存在  /etc/v2rayL/images"

if [ -d "/etc/v2rayL/images" ];then
    echo "已存在/etc/v2rayL/images"
else
    wget -P /etc/v2rayL http://cloud.thinker.ink/download/images-v2.0.1.tar
    cd /etc/v2rayL
    tar -xvf images-v2.0.1.tar
fi

rm /etc/v2rayL/v2ray-core.tar
rm /etc/v2rayL/images-v2.0.1.tar

echo "正在下载v2rayLui"
sudo wget -O /usr/bin/v2rayL/v2rayLui http://cloud.thinker.ink/download/v2rayLui-v2.0.1
sudo chmod +x /usr/bin/v2rayL/v2rayLui
echo "下载依赖文件"
sudo apt-get install zbar-tools -y

current_user=$USER
echo "设置桌面图标"
sudo wget -P /usr/share/applications http://cloud.thinker.ink/download/v2rayL.desktop
sudo chmod u+x /usr/share/applications/v2rayL.desktop
echo "$current_user ALL=NOPASSWD:/bin/systemctl restart v2rayL.service,/bin/systemctl start v2rayL.service,/bin/systemctl stop v2rayL.service,/bin/systemctl status v2rayL.service,/bin/systemctl enable v2rayL.service" | sudo tee -a /etc/sudoers
echo "设置开机自启动"
sudo systemctl enable v2rayL.service
/usr/bin/v2rayL/v2rayLui &
echo "安装完成."

