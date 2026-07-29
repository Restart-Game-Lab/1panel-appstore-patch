# 1Panel Appstore Patch

基于 1Panel 官方应用商店的补丁版本应用集合。

## 包含应用

### [OpenResty Tongsuo](apps/openresty-tongsuo/README.md)

集成铜锁 (Tongsuo) 国密密码学库的 OpenResty，替代标准 OpenSSL，支持 SM2/SM3/SM4/TLCP 等国密算法。

### [PostgreSQL pgvector](apps/postgresql-pgvector/README.md)

预装 pgvector、PostGIS、pg_cron、pg_repack、pg_hint_plan 等扩展的 PostgreSQL。

## 安装方式

### 方式一：手动复制

```bash
git clone https://github.com/Restart-Game-Lab/1panel-appstore-patch.git
cp -rf 1panel-appstore-patch/apps/* /opt/1panel/resource/apps/local/
```

### 方式二：使用脚本

```bash
git clone https://github.com/Restart-Game-Lab/1panel-appstore-patch.git
cd 1panel-appstore-patch
bash install.sh
```

安装后在 1Panel 应用商店的「本地应用」中即可看到新增的应用。

## Docker 镜像

补丁镜像通过 GitHub Actions 自动构建。各镜像的详细版本列表请参考对应应用的 README。

不使用 1Panel 的用户可以直接 pull 镜像使用：

```bash
# OpenResty Tongsuo
docker pull ghcr.io/restart-game-lab/openresty-tongsuo:latest

# PostgreSQL Patch (选择版本)
docker pull ghcr.io/restart-game-lab/postgresql-patch:18.4-alpine-patch
```

## 许可证

本项目基于 GPL-3.0 许可证开源。
