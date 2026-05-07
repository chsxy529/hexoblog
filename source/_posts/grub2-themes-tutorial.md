---
title: GRUB2 美化主题安装教程
date: 2026-05-07 16:30:00
type:
description: 详细介绍如何安装和配置 vinceliuice/grub2-themes 项目提供的现代 GRUB2 引导界面主题
keywords: [GRUB2, 主题美化, Linux, 引导界面, grub2-themes]
comments: true
top_img: https://raw.githubusercontent.com/vinceliuice/grub2-themes/master/preview.png
mathjax: false
katex: false
aside: true
aplayer: false
highlight_shrink: false
---

# GRUB2 美化主题安装教程

## 项目简介

[grub2-themes](https://github.com/vinceliuice/grub2-themes) 是由 vinceliuice 开发的一套现代风格的 GRUB2 引导界面主题集合。项目提供了多种主题风格、图标样式和屏幕分辨率选项，让你的开机引导界面焕然一新。

**项目地址：** https://github.com/vinceliuice/grub2-themes

---

## 可用选项

### 主题风格（Theme）

| 主题名 | 说明 |
|--------|------|
| `tela` | 默认主题，简洁现代 |
| `vimix` | 透明风格 |
| `stylish` | 时尚风格 |
| `whitesur` | macOS Big Sur 风格 |

### 图标样式（Icon）

| 图标名 | 说明 |
|--------|------|
| `color` | 默认彩色图标 |
| `white` | 白色图标 |
| `whitesur` | macOS 风格图标 |

### 屏幕分辨率（Screen）

| 分辨率 | 说明 |
|--------|------|
| `1080p` | 1920×1080（默认） |
| `2k` | 2560×1440 |
| `4k` | 3840×2160 |
| `ultrawide` | 超宽屏 |
| `ultrawide2k` | 超宽 2K 屏 |
| 自定义 | 如 `1600x900` |

---

## 安装步骤

### 1. 克隆项目

```bash
git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes
```

### 2. 基本安装（使用默认配置）

直接运行安装脚本，会弹出交互式对话框让你选择：

```bash
sudo ./install.sh
```

### 3. 命令行安装（推荐）

使用命令行参数可以精确控制安装选项：

```bash
# 安装 tela 主题 + 彩色图标 + 1080p 分辨率
sudo ./install.sh -t tela -i color -s 1080p

# 安装 vimix 主题 + 白色图标 + 2K 分辨率
sudo ./install.sh -t vimix -i white -s 2k

# 安装 whitesur 主题 + whitesur 图标 + 4K 分辨率
sudo ./install.sh -t whitesur -i whitesur -s 4k

# 自定义分辨率
sudo ./install.sh -t tela -i color -c 1600x900
```

### 4. 安装参数说明

| 参数 | 长参数 | 说明 |
|------|--------|------|
| `-t` | `--theme` | 选择主题风格 |
| `-i` | `--icon` | 选择图标样式 |
| `-s` | `--screen` | 选择屏幕分辨率 |
| `-c` | `--custom-resolution` | 自定义分辨率（如 `1600x900`） |
| `-r` | `--remove` | 移除已安装的主题 |
| `-b` | `--boot` | 安装到 `/boot/grub` 或 `/boot/grub2` |
| `-g` | `--generate` | 生成主题到指定目录（不安装） |
| `-h` | `--help` | 显示帮助信息 |

---

## 卸载主题

```bash
sudo ./install.sh -r -t tela
```

---

## NixOS 安装方法

NixOS 用户需要启用 **flakes** 功能：

### 1. 编辑 flake.nix

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, grub2-themes, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        grub2-themes.nixosModules.default
      ];
    };
  };
}
```

### 2. 配置 configuration.nix

```nix
{
  boot.loader.grub = {
    theme = grub2-themes.packages.x86_64-linux.default;
    splashImage = ./path/to/your/background.png;
  };
}
```

### 3. 重建系统

```bash
sudo nixos-rebuild switch --flake .
```

---

## 常见问题

### 分辨率不正确

如果 GRUB 显示的分辨率不对，可以手动设置：

**1. 查看支持的分辨率**

在 GRUB 命令行中执行：

```
vbeinfo
```

或：

```
videoinfo
```

**2. 编辑 GRUB 配置**

```bash
sudo nano /etc/default/grub
```

添加或修改：

```
GRUB_GFXMODE=1920x1080x32
GRUB_GFXPAYLOAD_LINUX=keep
```

**3. 重新生成 GRUB 配置**

```bash
# Debian/Ubuntu
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Arch Linux
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Fedora/RHEL
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

### 自定义背景图片

**1. 准备图片**

使用 ImageMagick 将图片调整为你的屏幕分辨率：

```bash
# 安装 ImageMagick
sudo apt install imagemagick  # Debian/Ubuntu
sudo pacman -S imagemagick    # Arch Linux

# 调整图片大小
convert background.jpg -resize 1920x1080! background_resized.jpg
```

**2. 安装时指定自定义分辨率**

```bash
sudo ./install.sh -c 1920x1080 -t tela -i color
```

---

## 参考资料

- [项目预览图](https://github.com/vinceliuice/grub2-themes/blob/master/preview.png)
- [GRUB2 主题参考文档](https://wiki.rosalab.ru/en/index.php/Grub2_theme_/_reference)
- [GRUB2 主题教程](https://wiki.rosalab.ru/en/index.php/Grub2_theme_tutorial)

---

## 总结

grub2-themes 是一个简单易用的 GRUB2 主题美化工具，通过一行命令即可让你的引导界面焕然一新。支持多种主题风格和分辨率，兼容主流 Linux 发行版和 NixOS。如果你厌倦了默认的 GRUB 界面，不妨试试这个项目。
