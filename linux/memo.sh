
# @@------------------------------安装备份-------------------------------

funcmemo(){

# Conda及pip修改默认仓库位置
~/.condarc
~/.pip/pip.conf

# Maven和Sbt默认仓库设置，在idea里设置好，仓库地址在属性配置文件里设置


# WPS图标
表格	/usr/share/icons/hicolor/256x256/apps/wps-office-etmain.png
PPT		/usr/share/icons/hicolor/256x256/apps/wps-office-wppmain.png
WORD    /usr/share/icons/hicolor/256x256/apps/wps-office-wpsmain.png

# XMind
exec:/home/alanding/software/xmind-8/XMind_amd64/XMindadd.sh
icons:/home/alanding/software/xmind-8/XMind_amd64/xmind.png


#  终端颜色
#555753 #F9555F #83ADDA #FDF029 #FCAF3E #AD7FA8 #1E9EE6 #BBBBBB #FFFFFF
#8AE234 #FA8B8E #34BB99 #FFFF55 #589CF5 #E75598 #8AE234 #FFFFFF #1C2836


#  版本修改gcc and g++
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 60
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 40
#   切换版本
update-alternatives --config gcc
#   删除
update-alternatives --remove gcc /usr/bin/gcc-4.6


#  Java版本切换
sudo update-alternatives --set java  /usr/local/java/jdk1.8.0_181/bin/java
sudo update-alternatives --set javac  /usr/local/java/jdk1.8.0_181/bin/javac
sudo update-alternatives --set javaws  /usr/local/java/jdk1.8.0_181/bin/javaws


# Conda 换源
conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
conda config --adzd channels https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes 

# 更新tex源
sudo tlmgr option repository http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet


# JupyterNB 配置
1, 插件安装配置
	pip install jupyter_contrib_nbextensions
	jupyter contrib nbextension install --user --skip-running-check

	# @VIM插件安装
	# @Create required directory in case (optional)
		mkdir -p $(jupyter --data-dir)/nbextensions
	# @Clone the repository
		cd $(jupyter --data-dir)/nbextensions
		git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
	# @Activate the extension
		jupyter nbextension enable vim_binding/vim_binding

2, 切换环境需要在使用的环境中安装 ipykernel 或者nb_conda

3, 初始化配置文件
	jupyter notebook --generate-config --allow-root
	/root/.jupyter/jupyter_notebook_config.py	# 配置文件地址

4, 修改默认配置, 别忘了行首的#
	c.NotebookApp.allow_root = False	# 修改root限制
	c.NotebookApp.ip = '0.0.0.0'  		# 修改本地登录
	c.NotebookApp.notebook_dir = u'/opt/jupyter'	# 修改默认启动位置

5, 加入密码
	>>:from notebook.auth import passwd
	passwd()
	# 配置文件中修改：
	c.NotebookApp.password = u'sha1:da874cad4309:4104089e5ef97c8fcbe69c2ac7d6a1071ca50a40'

# Cudnn 更换版本需要修改地址
sudo cp cuda/include/cudnn.h /opt/cuda/cuda-10.0/include
sudo cp cuda/lib64/libcudnn* /opt/cuda/cuda-10.0/lib64
sudo chmod a+r /opt/cuda/cuda-10.0/include/cudnn.h

## @这是结尾----------------------------------------
}

