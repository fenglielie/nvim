# My LazyVim

## nvim 安装

在Linux系统中默认都没有安装nvim，需要自行安装，官方的包管理器中的版本都太老了，最新的版本是0.10.x，nvim最新版要求至少glibc 2.31。（至少Ubuntu 20）
由于这些 nvim 插件对版本很敏感，不同插件的版本之间可能会有很多问题，尽量都使用最新版。

从 [nvim 仓库]([neovim/neovim: Vim-fork focused on extensibility and usability (github.com)](https://github.com/neovim/neovim)) 获取最新版的预编译的Tarball压缩包 [nvim-linux64.tar.gz](https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz) ，直接解压到本地就可以使用了，无须执行任何额外命令。

有两种配置方式：

- 第一种方式是将对应的路径加到PATH中，保持 nvim 的目录独立性；
- 第二种方式是将解压后的子文件夹（包括`bin/`，`lib/`等）与`/usr/local/`或`~/.local/`位置下的对应子文件夹合并。
```bash
cp -R * ~/.local/
```

安装之后检查一下即可
```bash
which nvim
nvim --version
```

## nvim 配置目录

nvim 完全遵循XDG规范，使用的目录和配置文件主要包括：

- `~/.config/nvim/`：配置文件目录
  - `~/.config/nvim/init.lua`：核心启动文件，主要用来引导加载其它配置文件。
  - `~/.config/nvim/lua/`：约定的配置文件目录，其中包括所有的配置文件，对于其中的子目录也可以继续提供 `init.lua`。
- `~/.local/share/nvim`	持久数据文件，包括插件，丢失后需要重新安装插件或下载
- `~/.local/state/nvim`	短期运行状态数据，丢失后会丢失 session、undo、历史记录
- `~/.cache/nvim`：缓存数据，用于加速程序的运行，丢失后 Neovim 会重新生成，不影响功能

nvim 配置文件目录通常形如
```
nvim
├── init.lua
└── lua
    ├── colorscheme.lua
    ├── config
    │   └── nvim-cmp.lua
    ├── keymaps.lua
    ├── lsp.lua
    ├── options.lua
    └── plugins.lua
```

对配置文件的修改通常需要重启 nvim 才会生效。


## nvim API

- vim.opt 现代接口（代替旧的vim.o，vim.wo，vim.bo）
- vim.keymap.set （代替旧的vim.api.nvim_set_keymap）
- vim.api.nvim_create_* 高级API，细颗粒度控制
- vim.g 设置全局变量（唯一方式）
- vim.fn 调用 vimscript 函数
- vim.cmd 执行 vimscript 命令

## LazyVim 配置

LazyVim 是一套开箱即用的 nvim 配置方案，基于 lazy.vim 进行插件管理。

使用方式如下：

- 备份当前的 nvim 配置
```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

- 克隆 starter 仓库，并将其改为自己的独立仓库
```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git
cd ~/.config/nvim
git init
```

## LazyVim 基础操作

快速退出nvim：`<leader>qq`

nvim 多个buffer之间切换：`<shift+h>`和`<shift+l>` 即H和L
对于buffer的相关操作：`<leader>b`

nvim 打开/关闭文件浏览器：`<leader>e` 或者 `<leader>E`，两者打开的位置不一样，e可能自动根据git判定项目根路径。

nvim 在文件管理器中：回车可以打开或关闭文件夹。a可以创建文件或文件夹（要求/结尾）

nvim 在文件管理器和主页面之间切换：ctrl+hjkl，（其实就是在windows之间切换）

`<shift+h>` 切换是否展示hidden文件
`<shift+i>` 切换是否展示gitignore忽略的文件


## 参考资料

- [LazyVim Github](https://github.com/LazyVim/LazyVim)
- [LazyVim doc](https://www.lazyvim.org/)
- [lazy.nvim Github](https://github.com/folke/lazy.nvim)
- [lazy.nvim doc](https://lazy.folke.io/)
- [从零开始配置 Neovim(Nvim)](https://martinlwx.github.io/zh-cn/config-neovim-from-scratch)
- [【Vim】可能是B站最系统的Vim教程](https://www.bilibili.com/video/BV1s4421A7he/?share_source=copy_web&vd_source=4dd36b43694defc3f41604b0fa5aac75)
- [用 neovim 写 markdown 是一种什么样的体验(含技巧)](https://yelog.org/2024/08/02/write-markdown-in-neovim-experience-and-tips/)

