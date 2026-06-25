# 1Panel Appstore Patch

基于 1Panel 官方应用商店的补丁版本应用集合。

## 包含应用

| 应用 | 说明 |
|------|------|
| **OpenResty Tongsuo** | 集成铜锁 (Tongsuo) 国密密码学库的 OpenResty，支持 SM2/SM3/SM4/TLCP |
| **PostgreSQL pgvector** | 预装 pgvector、PostGIS、pg_cron、pg_repack 等扩展的 PostgreSQL |

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

安装后在 1Panel 应商店的「本地应用」中即可看到新增的应用。

## Docker 镜像

应用使用的 Docker 镜像托管在 GitHub Container Registry (GHCR)：

- `ghcr.io/restart-game-lab/openresty-tongsuo`
- `ghcr.io/restart-game-lab/postgresql-patch`

## 许可证

本项目基于 MIT 许可证开源。
