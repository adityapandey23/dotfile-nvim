return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Connects LSP with nvim-cmp
    "hrsh7th/cmp-buffer",   -- Buffer completions
    "hrsh7th/cmp-path",     -- File path completions
    "L3MON4D3/LuaSnip",     -- Snippet engine (optional but useful)
    "saadparwaiz1/cmp_luasnip", -- Snippet completions
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
	expand = function(args)
	  luasnip.lsp_expand(args.body)
	end,
      },
      mapping = cmp.mapping.preset.insert({
	["<C-Space>"] = cmp.mapping.complete(),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<Tab>"] = cmp.mapping(function(fallback)
	  if cmp.visible() then
	    cmp.select_next_item()
	  elseif luasnip.expand_or_jumpable() then
	    luasnip.expand_or_jump()
	  else
	    fallback()
	  end
	end, { "i", "s" }),
	["<S-Tab>"] = cmp.mapping(function(fallback)
	  if cmp.visible() then
	    cmp.select_prev_item()
	  elseif luasnip.jumpable(-1) then
	    luasnip.jump(-1)
	  else
	    fallback()
	  end
	end, { "i", "s" }),
      }),
      sources = {
	{ name = "nvim_lsp" },
	{ name = "luasnip" },
	{ name = "buffer" },
	{ name = "path" },
      },
    })
  end,
}
