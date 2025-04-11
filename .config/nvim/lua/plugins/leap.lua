return {
	'ggandor/leap.nvim',
	config = function()
		require('leap').add_default_mappings()
		require('leap').opts.special_keys.next_group = '<è>'
	end
}
