
## -----------------------------安装备份-------------------------------


###  Conda及pip配置文件路径  
```
~/.condarc  
~/.pip/pip.conf
```


###  WPS图标
```
表格	/usr/share/icons/hicolor/256x256/apps/wps-office-etmain.png  
PPT		/usr/share/icons/hicolor/256x256/apps/wps-office-wppmain.png  
WORD  /usr/share/icons/hicolor/256x256/apps/wps-office-wpsmain.png
```


###  终端颜色
```
#555753 #F9555F #83ADDA #FDF029 #FCAF3E #AD7FA8 #1E9EE6 #BBBBBB #FFFFFF
#8AE234 #FA8B8E #34BB99 #FFFF55 #589CF5 #E75598 #8AE234 #FFFFFF #1C2836
```


###  版本修改
> 1. gcc and g++  
```
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60  
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40  
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 60  
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 40  
```
> 2. 切换版本  
`update-alternatives --config gcc`
> 3. 删除  
`update-alternatives --remove gcc /usr/bin/gcc-4.6`


###  Java版本切换
```
sudo update-alternatives --set java  /usr/local/java/jdk1.8.0_181/bin/java
sudo update-alternatives --set javac  /usr/local/java/jdk1.8.0_181/bin/javac
sudo update-alternatives --set javaws  /usr/local/java/jdk1.8.0_181/bin/javaws
```


###  Conda 换源
```
conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
conda config --adzd channels https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes 
```


###  更新tex源
```
sudo tlmgr option repository http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet
```


### JupyterNB 配置
> 1. 插件安装配置  
	`pip install jupyter_contrib_nbextensions`  
	`jupyter contrib nbextension install --user --skip-running-check`  
>	
>	2. VIM插件安装  
>    @Create required directory in case (optional)  
> 		 `mkdir -p $(jupyter --data-dir)/nbextensions`  
>    @Clone the repository  
>		   `cd $(jupyter --data-dir)/nbextensions`  
>		   `git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding`  
>	   @Activate the extension  
>		   `jupyter nbextension enable vim_binding/vim_binding`
>	
> 3. 切换环境需要在使用的环境中安装 ipykernel 或者nb_conda
> 
> 4. 初始化配置文件  
	jupyter notebook --generate-config --allow-root
	~/.jupyter/jupyter_notebook_config.py	# 配置文件地址  
> 5. 修改默认配置, 别忘了注释掉行首的#  
	c.NotebookApp.allow_root = False	# 修改root限制  
	c.NotebookApp.ip = '0.0.0.0'  		# 修改本地登录  
	c.NotebookApp.notebook_dir = u'/home/alanding/0_Dev/Python-projects/Jupyter'	# 修改默认启动位置  
> 
> 6. 加入密码
	# >>:from notebook.auth import passwd
	# passwd()
	# 配置文件中修改：
	c.NotebookApp.password = u''
