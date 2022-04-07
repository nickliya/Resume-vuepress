# Resume-vuepress

## 简介

通过本项目，你可以使用 Markdown 书写简历，并通过 VuePress 部署为可预览的页面。

[点击此处预览项目](https://nickliya.github.io/Resume-vuepress)

### 依赖

1. vuepress 2.0+ (https://v2.vuepress.vuejs.org/zh/)
  
2. forked from [Siricee/Resume-vuepress](https://github.com/Siricee/Resume-vuepress)
  

## 使用说明

### 1. 安装

1. clone本项目并安装依赖
  

```bash
git clone https://github.com/nickliya/Resume-vuepress.git

cd Resume-vuepress

yarn install
```

### 2. 开发

正式开发前，可以先阅读 [VuePress官方文档](https://v2.vuepress.vuejs.org/zh/)。

在`resume`文件夹内，根据`scaffold.md`修改`README.md`并保存。

然后执行以下命令进行预览或打包

```bash
npm run dev # 预览

npm run build # 生成静态页面
```

**打印简历**：

Chrome 页面中右键 -> 打印 -> 另存为 pdf。

*注意：打印-更多设置-取消勾选页眉和页脚。否则会有标题和日期。*

## 部署

**Github-Pages部署说明：**

**本项目部署的前置条件**

1. 已经通过yarn build命令成功打包:

2. 在 `resume/.vuepress/config.js` 中设置正确的 `base`

```javascript
module.exports = {
  lang: "zh-CN",
  title: "Yongchin's Resume",
  description: "这是我的第一个 VuePress 站点",
  base: "/Resume-vuepress/",

  // 主题配置
  themeConfig: {
    navbar: false,
    sidebar: [
      {
        title: "简历",
        collapsable: false,
        children: ["/"],
      },
    ],
  },
};
```

###

### 1.自动化部署

我们可以通过github actions进行自动化部署

<font color="red">项目中已经自带自动化部署的配置文件 .github/workflows/docs.yaml</font>

<font color="red">当每次进行push提交到主分支main时，会自动触发github actions任务</font>

docs.yaml的详情如下

```yaml
name: resume update

on:
  # 每当 push 到 main 分支时触发部署
  push:
    branches: [main]
  # 手动触发部署
  workflow_dispatch:

jobs:
  docs:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
        with:
          # “最近更新时间” 等 git 日志相关信息，需要拉取全部提交记录
          fetch-depth: 0

      - name: Setup Node.js
        uses: actions/setup-node@v1
        with:
          # 选择要使用的 node 版本
          node-version: '14'

      # 缓存 node_modules
      - name: Cache dependencies
        uses: actions/cache@v2
        id: yarn-cache
        with:
          path: |
            **/node_modules
          key: ${{ runner.os }}-yarn-${{ hashFiles('**/yarn.lock') }}
          restore-keys: |
            ${{ runner.os }}-yarn-

      # 如果缓存没有命中，安装依赖
      - name: Install dependencies
        if: steps.yarn-cache.outputs.cache-hit != 'true'
        run: yarn --frozen-lockfile

      # 运行构建脚本
      - name: Build VuePress site
        run: yarn build

      # 查看 workflow 的文档来获取更多信息
      # @see https://github.com/crazy-max/ghaction-github-pages
      - name: Deploy to GitHub Pages
        uses: crazy-max/ghaction-github-pages@v2
        with:
          # 部署到 gh-pages 分支
          target_branch: gh-pages
          # 部署目录为 VuePress 的默认输出目录
          build_dir: resume/.vuepress/dist
        env:
          # @see https://docs.github.com/cn/actions/reference/authentication-in-a-workflow#about-the-github_token-secret
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### 2.手动本地部署

本地进入项目中执行`deploy.sh`即可自动部署到github pages。

deploy.sh 的详情如下（**请自行判断启用注释掉的命令**）:

```shell
#!/usr/bin/env sh
# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
yarn build

# 进入生成的文件夹
cd resume/.vuepress/dist

# 推送到远程仓库
git init
git add -A
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git main

# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git main:gh-pages

cd -
```

更多部署方式可以参阅 [VuePress文档|部署](https://v1.vuepress.vuejs.org/guide/deploy.html)。

---

Author：[@Yongchin](https://github.com/nickliya)