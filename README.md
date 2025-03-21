# 🌱 Grass miner

[Grass](https://app.getgrass.io/register/?referralCode=IlJGw0ovdrhi_mk)为用户提供了一种利用闲置的网络资源进行挖矿的新途径。

```sh
docker run \
    --name grass \
    --restart unless-stopped \
    --memory 1g \
    -p 8082:8080 \
    -v ~/.local/share:/root/.local/share \
    -v /etc/localtime:/etc/localtime:ro \
    -e VNC_PASS=CHANGE_IT \
    -d ccr.ccs.tencentyun.com/alone/grass
```

> 如遇到打不开Grass桌面客户端，可尝试使用特权模式(`--privileged`)运行容器。

### 可用镜像
- ghcr.nju.edu.cn/al-one/grass
- ccr.ccs.tencentyun.com/alone/grass
- alone/grass

### 操作步骤:
1. 注册Grass账号
   - https://app.getgrass.io/register/?referralCode=IlJGw0ovdrhi_mk
   - 邀请码: `IlJGw0ovdrhi_mk`
   - 填完注册信息后，如果注册按钮灰色不可点击，需要多刷新几次或者使用特殊网络环境(人机验证需要)
2. 执行上述命令安装容器，`CHANGE_IT`为默认远程访问密码
3. 在PC浏览器中打开`http://192.168.1.xxx:8082`，并输入命令中的访问密码
4. 登录刚才注册的账号即可
