return {
  {
    "ggandor/leap.nvim",
    config = function()
      -- Highly recommended: define a preview filter to reduce visual noise
      -- and the blinking effect after the first keypress
      -- (`:h leap.opts.preview`). You can still target any visible
      -- positions if needed, but you can define what is considered an
      -- exceptional case.
      -- Exclude whitespace and the middle of alphabetic words from preview:
      --   foobar[baaz] = quux
      --   ^----^^^--^^-^-^--^
      require("leap").opts.preview = function(ch0, ch1, ch2)
        return not (
          ch1:match("%s")
          or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
        )
      end
    end
  }
}
