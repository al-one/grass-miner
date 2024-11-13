# 🌱 Grass miner

[Grass](https://app.getgrass.io/register/?referralCode=IlJGw0ovdrhi_mk)为用户提供了一种利用闲置的网络资源进行挖矿的新途径。

```sh
docker run \
    --name grass \
    --restart unless-stopped \
    -p 8082:8080 \
    -e VNC_PASS=CHANGE_IT \
    -d alone/grass
```

操作步骤:
1. 注册Grass账号
  - https://app.getgrass.io/register/?referralCode=IlJGw0ovdrhi_mk
  - 邀请码: `IlJGw0ovdrhi_mk`
  - 填完注册信息后，如果注册按钮灰色不可点击，需要多刷新几次或者使用特殊网络环境(人机验证需要)
2. 执行上述命令安装容器，`CHANGE_IT`为默认远程访问密码
3. 在PC浏览器中打开`http://192.168.1.xxx:8082`，并输入命令中的访问密码
4. 登录刚才注册的账号即可
