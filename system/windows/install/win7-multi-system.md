## Windows7 安装多系统

### 系统环境
* 磁盘：MBR磁盘分区格式
* 软件：easybcd，ultraiso，fixmbr，PE，diskgenius
* 系统：windows7


### 准备工作
* 制作linux 启动盘  
	
	1.首先从网上下载linuxISO镜像  
	2.打开ultraiso，选择**`写入硬盘映像`**  
	3.进入刻录界面后首先选择**`格式化`**（请注意选择正确的U盘，以免造成数据丢失）  
	4.**`写入`**完成后，选择**`便捷启动`--`写入新引导扇区`--`Syslinux`**

* PE启动准备  

	1.将U盘制作成PE，可以选择在网上下载大白菜等类似PE软件  
	2.安装PE后进入bios将启动项设置为U盘启动  
	3.如果主板开启了secure boot，则需要先关闭  
	4.如果主板默认为UEFI启动模式则需要设置Lagecy启动模式（如果PE支持UEFI启动则可以不调整）

* 如果磁盘为GPT格式则需要将磁盘转换成MBR  

	1.使用diskgenuis将磁盘转换为MBR格式，如果磁盘存在重要数据，最好先做一次备份  
	2.预留一个分区给linux系统用，可以是扩展分区
	
### 系统安装
	
* 安装Linux
	
	1.重启后从linux 启动盘启动  
	2.出现安装界面，在linux安装过程中选择磁盘分区时请注意选择正确的分区（扩展分区占一个磁盘号，如sda3，扩展分区内的第一个分区为sda4或者sda5） 
	3.安装完成后重启电脑，将U盘拔除  
	
* 修复MBR

	1.重启默认会进入到linux系统，此时需要在linux引导时选择启动windows  
	2.进入windows后，将下载好的 fixmbr拷贝到system32目录  
	3.运行**`mbrfix /drive 0 fixmbr /yes`**  

* 修改windows启动菜单

	1.重启电脑后发现默认从windows启动了  
	2.打开easybcd，点击**`添加新条目`--`Linux/BCD`--`选择linux系统分区`--`添加条目`**  
	3.点击**`编辑引导菜单`**，如果windows不是默认则修改为默认启动  
	4.重启windows系统发现多了一个启动菜单了  

### 注意事项
* 如果安装完linux后无法找到windows启动菜单，则需要进入PE，使用diskgenius修复MBR引导即可
* 按照如上方式可以安装多个linux系统，原理是一样的
* UEFI下引导GPT磁盘方式未做尝试，但是按照引导原理应该也可以行得通，使用GPT可以识别2T以上硬盘，另外无主分区概念，这样安装linux多系统会更加方便