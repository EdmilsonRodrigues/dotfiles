# Everforest Minimal OMZ Theme
# Colors mapped via ANSI codes set in Kitty theme:
# %F{2} = Moss Emerald (Success)
# %F{1} = Crimson Spore (Error)
# %F{6} = Bioluminescent Cyan (Directory)
# %F{3} = Warm Amber (Git)

# Exit Status: Green arrow on success (0); Red arrow + Exit Code on failure
local status_indicator="%(?:%F{2}➜ :%F{1}➜ [%?] )"

# Directory: %c displays ONLY the current folder name
local current_dir="%F{6}%c%f"

# Prompt string assembly
PROMPT="${status_indicator}${current_dir} \$(git_prompt_info)"

# Git Formatting
ZSH_THEME_GIT_PROMPT_PREFIX="%F{4}git:(%F{3}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{4})%f "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{1}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
