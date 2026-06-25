# 1Panel Appstore Patch

基于 1Panel 官方应用商店的补丁版本应用集合。

## 包含应用

### OpenResty Tongsuo

集成铜锁 (Tongsuo) 国密密码学库的 OpenResty，支持 SM2/SM3/SM4/TLCP。

| 版本 | 说明 | 镜像 |
|------|------|------|
| 1.21.4.3-3-3-focal | 官方镜像，无国密 | `1panel/openresty:1.21.4.3-3-3-focal` |
| 1.27.1.2-5-1-focal | 官方镜像，无国密 | `1panel/openresty:1.27.1.2-5-1-focal` |
| 1.29.2.5-0-noble | 官方镜像，无国密 | `1panel/openresty:1.29.2.5-0-noble` |
| **1.31.1.1-0-noble-tongsuo** | **铜锁国密版** | `ghcr.io/restart-game-lab/openresty-tongsuo` |

### PostgreSQL pgvector

预装 pgvector、PostGIS、pg_cron、pg_repack 等扩展的 PostgreSQL。

| 版本 | 说明 | 镜像 |
|------|------|------|
| 12.22-alpine | 官方镜像，无扩展 | `postgres:12.22-alpine` |
| 13.23-alpine | 官方镜像，无扩展 | `postgres:13.23-alpine` |
| **14.23-alpine-patch** | 预装扩展版 | `ghcr.io/restart-game-lab/postgresql-patch:14.23-alpine-patch` |
| **15.18-alpine-patch** | 预装扩展版 | `ghcr.io/restart-game-lab/postgresql-patch:15.18-alpine-patch` |
| **16.14-alpine-patch** | 预装扩展版 | `ghcr.io/restart-game-lab/postgresql-patch:16.14-alpine-patch` |
| **17.10-alpine-patch** | 预装扩展版 | `ghcr.io/restart-game-lab/postgresql-patch:17.10-alpine-patch` |
| **18.4-alpine-patch** | 预装扩展版 | `ghcr.io/restart-game-lab/postgresql-patch:18.4-alpine-patch` |

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

## Docker 镜像构建

补丁镜像通过 GitHub Actions 自动构建，每周更新一次。也可以手动触发构建。

| 镜像 | Workflow | 说明 |
|------|----------|------|
| `ghcr.io/restart-game-lab/openresty-tongsuo` | `docker-openresty.yml` | OpenResty + 铜锁国密 |
| `ghcr.io/restart-game-lab/postgresql-patch` | `docker-postgresql.yml` | PostgreSQL + pgvector/PostGIS/pg_cron |

不使用 1Panel 的用户可以直接 pull 镜像使用：

```bash
# OpenResty Tongsuo
docker pull ghcr.io/restart-game-lab/openresty-tongsuo:latest

# PostgreSQL Patch (选择版本)
docker pull ghcr.io/restart-game-lab/postgresql-patch:18.4-alpine-patch
```

## 许可证

本项目基于 MIT 许可证开源。
