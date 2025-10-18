# NVIM 学习笔记

> 这玩意实在是太复杂了，还是算了吧。

学习一下nvim吧，目标是纯命令行使用nvim完成：C++、Python 和 Markdown 的编写。
尽量减少nvim插件的安装，不打算将nvim鼓捣为一个vscode风格的IDE。

## 安装 nvim

在Linux系统中默认都没有安装nvim，需要自行安装，官方的包管理器中的版本都太老了，最新的版本是0.10.x，nvim最新版要求至少glibc 2.31。（至少Ubuntu 20）
由于这些nvim插件对版本很敏感，不同插件的版本之间可能会有很多问题，尽量都使用最新版。


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

## 配置目录

nvim 完全遵循XDG规范，使用的目录和配置文件主要包括：

- `~/.config/nvim/`：配置文件目录
  - `~/.config/nvim/init.lua`：核心启动文件，主要用来引导加载其它配置文件。
  - `~/.config/nvim/lua/`：约定的配置文件目录，其中包括所有的配置文件，对于其中的子目录也可以继续提供 `init.lua`。
- `~/.local/share/nvim`	持久数据文件，包括插件，丢失后需要重新安装插件或下载
- `~/.local/state/nvim`	短期运行状态数据，丢失后会丢失 session、undo、历史记录
- `~/.cache/nvim`：缓存数据，用于加速程序的运行，丢失后 Neovim 会重新生成，不影响功能


我们主要关注配置目录，整体结构例如
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

注意：对配置文件的修改通常需要重启 nvim 才会生效。

## nvim 基础操作

在使用各种插件之前，先整理一下 nvim 的一些基础操作。

关于nvim的常见API：

- vim.opt 现代接口（代替旧的vim.o，vim.wo，vim.bo）
- vim.keymap.set （代替旧的vim.api.nvim_set_keymap）
- vim.api.nvim_create_* 高级API，细颗粒度控制
- vim.g 设置全局变量（唯一方式）
- vim.fn 调用 vimscript 函数
- vim.cmd 执行 vimscript 命令



## 尝试手动管理插件

## lazy.nvim 插件管理器

## lazyvim 配置和基础操作


## 参考资料

- [从零开始配置 Neovim(Nvim)](https://martinlwx.github.io/zh-cn/config-neovim-from-scratch)
- [【Vim】可能是B站最系统的Vim教程](https://www.bilibili.com/video/BV1s4421A7he/?share_source=copy_web&vd_source=4dd36b43694defc3f41604b0fa5aac75)
- [用 neovim 写 markdown 是一种什么样的体验(含技巧)](https://yelog.org/2024/08/02/write-markdown-in-neovim-experience-and-tips/)


## 之前的一些配置记录

```
    local config = opts.sections

    -- rewrite lualine_z
    config.lualine_z = {
      { "encoding" },
      {
        "fileformat",
        icons_enabled = true,
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
    }

```

```
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false -- default: true (underline)
  end,
})
```

```
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.listchars = "tab:▷ ,trail:·,nbsp:+"
```

```
return {
    "tokyonight.nvim",
    priority = 1000,
    opts = function()
      return {
        style = "moon",
        -- transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
          comments = { italic = false },
          keywords = { italic = false },
          functions = { italic = false },
          variables = { italic = false },
        },
      }
    end,
}
```

```
return {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
        vim.g.vimtex_syntax_conceal_disable = 1
        --   vim.api.nvim_create_autocmd({ "FileType" }, {
    --     group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
    --     pattern = { "bib", "tex" },
    --     callback = function()
    --       vim.wo.conceallevel = 0
    --     end,
    --   })
    --   vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
    --   vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

    --   vim.g.vimtex_view_method = "zathura"
    --   vim.g.vimtex_view_general_viewer = "zathura"

    --   vim.g.vimtex_view_skim_sync = 1
    --   vim.g.vimtex_view_skim_activate = 1
    --   vim.g.vimtex_view_skim_reading_bar = 1

    --   vim.g.vimtex_compiler_latexmk = {
    --     aux_dir = "./.aux",
    --     -- out_dir = ".",
    --   }

    end,
  }

```

快速退出nvim：`<leader>qq`

nvim 多个buffer之间切换：`<shift+h>`和`<shift+l>` 即H和L
对于buffer的相关操作：`<leader>b`

nvim 打开/关闭文件浏览器：`<leader>e` 或者 `<leader>E`，两者打开的位置不一样，e可能自动根据git判定项目根路径。

nvim 在文件管理器中：回车可以打开或关闭文件夹。a可以创建文件或文件夹（要求/结尾）

nvim 在文件管理器和主页面之间切换：ctrl+hjkl，（其实就是在windows之间切换）

`<shift+h>` 切换是否展示hidden文件
`<shift+i>` 切换是否展示gitignore忽略的文件


