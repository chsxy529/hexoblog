---
title: ios 修改定位
tags:
  - python
  - iphone
categories: PYTHON
cover: /img/arbg.png
top_img: 'https://i.loli.net/2020/05/01/gkihqEjXxJ5UZ1C.jpg'
series: 修改定位
abbrlink: 6bd7aea2
---
{% series %}



>  **GitHub 项目 [davesc63/GeoPort](https://github.com/davesc63/GeoPort/)** 的分析与完整使用教程，方便你阅读、学习和快速上手 👇 ([GitHub][1])

---

# 📍 GeoPort 使用教程

## 📌 项目简介

**GeoPort — Your Location, Anywhere!**
一个开源的 iOS 虚拟定位/模拟器工具，可让你在 iPhone/iPad 上模拟任意全球位置，无需越狱。支持最新的 iOS 18 和 iOS 26 系统版本，也提供跨平台客户端（Windows / macOS / Linux）。功能包括：

* 🌍 任意全球位置模拟
* 🧪 开发者测试基于位置的 App
* 📍 简单易用的地图拖拽定位界面
* 🛡️ 支持隐私控制与停止模拟 ([GitHub][1])

**项目地址**
[https://github.com/davesc63/GeoPort/](https://github.com/davesc63/GeoPort/) ([GitHub][1])

---

## 📦 系统需求

* 🖥️ Windows / macOS / Linux 电脑
* 📱 iOS 设备 (iPhone / iPad)
* iOS 17 或 iOS 18
* Windows 用户需先安装 **iTunes** 用于识别设备 ([GitHub][1])

---

## 🛠️ 安装 & 启动

### 1. 下载客户端

1. 访问 GitHub Releases 页面：
   [https://github.com/davesc63/GeoPort/releases](https://github.com/davesc63/GeoPort/releases) ([GitHub][2])
2. 下载对应平台包（Windows `.exe` / macOS `.app` / Linux 二进制）。
3. 解压或安装程序。

> 💡 Linux 版是可执行二进制文件，下载后需要加执行权限：
>
> ````bash
> chmod +x GeoPort
> ``` :contentReference[oaicite:5]{index=5}
> ````

---

## 🚀 快速启动教程

### 🎯 第一步 — 连接设备

1. 使用 USB 数据线将 iPhone / iPad 连接到电脑。
2. 如果是首次连接，在设备上点击 “信任此电脑”。

🔹 Windows 用户：确保安装了 iTunes，否则设备无法识别。 ([GitHub][1])

---

### 🐣 第二步 — 启动 GeoPort

运行下载的程序：

* Windows: 双击 `.exe`
* macOS: 打开 `.app`
* Linux: 在终端运行可执行文件

默认情况下，GeoPort 会启动一个本地 Web 界面（通常是 [http://localhost:54321）。](http://localhost:54321）。) ([Reddit][3])

---

## 🗺️ 第三步 — 模拟位置

1. 打开程序后的地图界面。
2. 在地图上搜索或点击选择你想要模拟的地点（城市 / 景点 / 经纬度）。
3. 点击 **Start Simulation**（开始位置模拟）。
4. 稍等几秒，设备的定位就会“瞬移”到所选位置。 

📌 若要停止模拟：
点击 **Stop Location**（停止位置）按钮。

---

## 🔧 设置 & 辅助说明

### 🔓 启用开发者模式（部分 iOS 版本需要）

部分新版本 iOS 可能要求开启 **开发者模式** 才能允许 GeoPort 更改位置。 若无法直接启用，可：

1. 进入 iOS 设置 → “隐私与安全性” → “开发者模式”。
2. 如找不到该选项：

   * 暂时移除设备锁屏密码
   * 运行 GeoPort 并按照提示启用开发者模式
   * 完成后可重新设置密码

📌 GeoPort 会在界面提示如何处理此步骤。 ([GitHub][1])

---

## 💡 高级用法（可选）

### 🛣️ 轨迹模拟（路线移动）

部分版本支持在地图上绘制多个点制作移动路径，用于模拟真实用户移动（需注意版本支持情况，可能依赖具体 release）。 ([GitHub][2])

---

## ❓ 常见问题

### 📱 设备无法识别

* Windows 未安装 **iTunes** 或驱动未正确加载。
* iOS 未信任当前电脑。
* 尝试重新插拔设备和重启 GeoPort。 ([GitHub][5])

---

## 💬 社区反馈 & Issues

GitHub Issues 中有一些常见主题，如：

* 设备识别失败
* iOS 版本兼容
* 路径模拟功能扩展需求等 ([GitHub][5])

👉 最新反馈可在 Issues 页面查看。 ([GitHub][5])

---

## 📜 许可协议

本项目采用 **GPL-3.0 许可证** 开源发布，你可以自由使用、修改和分发（遵循该协议条款）。 ([GitHub][1])

---

## 🧭 总结

GeoPort 是一个 **功能强大、跨平台、易用的 iOS 虚拟定位工具**，适用于：

* 🌏 虚拟旅游体验
* 📲 开发者测试定位功能
* 📍 社交/游戏定位需求

启动和操作非常简单，只需连接设备、选择位置即可模拟。 ([GitHub][1])

---

如果你需要 **GitHub 仓库结构说明**或想把这个项目 **移植/二次开发**，我也可以帮你写更详细的 **开发文档/架构解析** 👍

[1]: https://github.com/davesc63/GeoPort/ "GitHub - davesc63/GeoPort: GeoPort: Your Location, Anywhere! The iOS location simulator"
[2]: https://github.com/davesc63/GeoPort/releases?utm_source=chatgpt.com "Releases · davesc63/GeoPort"
[3]: https://www.reddit.com/r/linux4noobs/comments/1fp1967/need_help_using_program_from_github_in_ubuntu_x64/?utm_source=chatgpt.com "Need help using program from github in ubuntu x64"
[4]: https://ihacksoft.com/geoport/?utm_source=chatgpt.com "最新iOS 虚拟定位工具- GeoPort 轻松伪装全球任何位置"
[5]: https://github.com/davesc63/GeoPort/issues?utm_source=chatgpt.com "Issues · davesc63/GeoPort"
