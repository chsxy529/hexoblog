---
title: iPhone ios 修改定位
tags:
  - python
  - iphone
categories: PYTHON
cover: /img/arbg.png
top_img: https://i.loli.net/2020/05/01/gkihqEjXxJ5UZ1C.jpg


series: 修改定位

---

{% series %}


# GeoPort 使用教程

> 简短概述  
> GeoPort 是一款位置模拟（spoofing / virtual location）工具，允许你在地图上选择任意位置并将位置“发送”到 iOS 设备，用于演示、检查应用的定位功能或娱乐用途。此文基于仓库 README 与 FAQ（https://github.com/davesc63/GeoPort/blob/main/README.md 和 https://github.com/davesc63/GeoPort/blob/main/FAQ.md）整理并补充了使用流程、常见操作与故障排查要点。

[TOC]



---

## 项目概述
GeoPort 提供一个图形界面用于模拟设备地理位置，常见用途包括：
- 在任意地点“定位”你的设备
- 在地图上绘制或导入轨迹并在设备上回放（模拟移动）
- 将标记/轨迹保存为 GeoJSON/GPX 分享或备份
- 支持使用 Wi‑Fi 的“非绑线（untethered）”连接（需要先通过 USB 配对）

---

## 支持平台
- Windows 64-bit

- macOS (ARM & Intel)

- Linux — Ubuntu 22.04

  

---

## 获取与安装
1. 访问 Releases 页面下载对应平台的安装包或 DMG：  
   https://github.com/davesc63/GeoPort/releases
2. macOS：下载 DMG，打开后将应用拖入 Applications（首次运行可能需要在 系统设置 → 隐私与安全 中允许打开）。
3. Windows：下载并运行安装包（若首次运行出现防火墙提示，请允许 GeoPort 通信 —— 见故障排查）。
4. Linux：参考 Releases（或源码）中的说明来安装/运行。

提示：如果能找到 prebuilt 安装包（release），优先使用 release 版本而不是自己构建，除非你要修改源码。

---

## 快速开始
1. 安装并启动 GeoPort（按平台所下载的安装方式）。
2. 用 USB 线将 iPhone 连接到电脑，解锁 iPhone，并在设备上接收 / 信任配对请求（需要至少一次 USB 配对以启用 Wi‑Fi 发现）。
3. 在 GeoPort 中选择你的设备，然后在地图上双击放置标记或导入 GPX/GeoJSON，最后使用界面上的“发送/回放/播放速度”等控件将位置/轨迹发送至设备。

---

## 主要功能与详细操作

### 1) 连接设备（USB 与 Wi‑Fi）
- 初次使用：用 USB 连接设备并在手机上接受配对请求（必需）。FAQ 特别指出需至少一次 USB 连接以建立配对信息。
- Wi‑Fi（untethered）连接：GeoPort 集成了 pymobiledevice3 的 Wi‑Fi 功能；在设备已配对并在同一 LAN/subnet（Bonjour 发现）下，可以通过 Wi‑Fi 列表选择设备实现无线定位。若看不到设备，请解锁手机并点击刷新若干次；Wi‑Fi 并非 100% 稳定，取决于网络设备与子网配置。

### 2) 在地图上添加与编辑标记
- 双击地图放置一个图标（marker）。
- 右键单击该图标可打开属性弹窗，输入/修改该位置的详情（FAQ 中有说明）。
- 使用 “Download” 按钮可以将当前标记/数据另存为文件（GeoJSON 等）。

### 3) 绘制与回放轨迹
- 使用界面上的 `Line`（或 Draw Line）按钮：
  - 选择起点，在地图上逐点点击创建路线/轨迹。
  - 完成后可选择 `Download` 保存为 GPX/GeoJSON。
- 导入轨迹：点击 `Upload` 按钮，选择包含坐标或 GPX 文件，GeoPort 会加载该轨迹。
- 回放轨迹（Auto-walk / simulate movement）：
  - 上传 GPX / GeoJSON 文件后选择 `Speed`。
  - 选择速率（walk/run/ride/drive/custom），然后开始回放，设备上将按轨迹“移动”。

### 4) 回放速度说明（FAQ 中列出）
- walk = 6 km/h
- run = 12 km/h
- ride = 20 km/h
- drive = 50 km/h
- custom = 可输入三位数（km/h）

### 5) 导入 / 导出标记与轨迹
- Upload：导入包含坐标的文件（markers, GPX, GeoJSON）并加载到地图。
- Download：把当前选中的标记或轨迹保存为文件以便分享或复用。

### 6) 位置通知
- GeoPort 支持给设备发送定位相关的通知（README/FAQ 有演示 GIF），用于检测应用端的行为（例如应用在收到位置变更时是否有预期响应）。

---

## 开发者 / 从源码运行（提示）
- FAQ 提到 GeoPort 使用了 pymobiledevice3 来处理与 iOS 设备的连接与 Wi‑Fi 支持，因此源码运行或开发可能需要安装 Python 包与开发依赖（例如 pymobiledevice3）。
- 源码位于仓库的 src 目录（https://github.com/davesc63/GeoPort/tree/main/src）。自行构建或调试：
  - 克隆仓库：git clone https://github.com/davesc63/GeoPort.git
  - 阅读仓库根目录与 src 中的 README 或构建说明（若存在）。
  - 安装依赖：通常需要 Python 3.x 以及相关包（请以仓库内 requirements 或 setup 指示为准）。
- 若准备打包为桌面应用（Windows/macOS），注意可能需要用到 PyInstaller 或打包工具，并处理签名/证书（macOS 未签名会出现额外安全弹窗，FAQ 中有指导如何在隐私与安全中“打开”）。

---

## 常见问题与故障排查

1. 无法发现设备（Wi‑Fi）
   - 确保**已用 USB 与设备配对过一次**并在设备上选择信任。
   - 确保电脑和手机在**同一 LAN / 子网**，Bonjour 发现可能被路由器或交换机阻断。
   - 解锁手机并多次刷新设备列表。

2. Windows：Unable to create tunnel within timeout（通常防火墙问题）
   - 以管理员运行时如果遇到该错误，请检查 Windows 防火墙设置：
     - 控制面板 → 系统和安全 → 允许应用通过 Windows Defender 防火墙 → 找到 GeoPort 并允许 Public 和 Private，或删除条目并在下次运行时重新允许弹窗中两项都勾选。
   - 也可检查入站/出站规则（FAQ 中含图片示例）。

3. macOS：首次从 DMG 运行出现“无法打开应用”或安全提示
   - 打开 系统设置 → 隐私与安全 → 在允许的应用列表中选择 Open（或根据提示允许运行未签名应用）。

4. 设备不响应位置更改
   - 确认设备已连接并在 GeoPort 列表中为“在线”状态。
   - 确认目标应用允许使用设备位置（应用权限）。
   - 若使用 Wi‑Fi 连接，尝试切换回 USB 以确认是否为 Wi‑Fi 连接问题。

5. Too many open connections / Errno 54
   - FAQ 提到已修复与过多打开的连接相关的问题（若在旧版本出现该问题，升级到新版本或查看 release notes）。

---

## 资源与帮助
- 仓库主页（源码、下载、说明）：https://github.com/davesc63/GeoPort
- Releases（下载最新安装包与查看变更日志）：https://github.com/davesc63/GeoPort/releases
- FAQ（详细图示与操作示例）：https://github.com/davesc63/GeoPort/blob/main/FAQ.md
- 报告问题 / 请求帮助：在仓库 Issues 提交（https://github.com/davesc63/GeoPort/issues）
- 讨论与社区：Discord（README 中有邀请链接）
