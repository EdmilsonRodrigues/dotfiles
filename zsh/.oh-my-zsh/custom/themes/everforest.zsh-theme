# Everforest OMZ Theme with Kubectx
# Kitty ANSI Color mapping:
# %F{1} = Red (Crimson Spore)      | %F{2} = Green (Moss Emerald)
# %F{3} = Yellow (Warm Amber)     | %F{4} = Blue/Teal (Bioluminescent Teal)
# %F{5} = Magenta (Dusky Orchid)  | %F{6} = Cyan (Bioluminescent Cyan)

# Fetch active Kubernetes context without slowing down command entry
k8s_prompt_info() {
  if command -v kubectx >/dev/null 2>&1; then
    local context=$(kubectx -c 2>/dev/null)
    if [[ -n "$context" ]]; then
      echo "%F{4}k8s:(%F{5}${context}%F{4})%f "
    fi
  fi
}

# Exit Status: Green arrow on success; Red arrow + [Exit Code] on failure
local status_indicator="%(?:%F{2}➜ :%F{1}➜ [%?] )"

# Directory: %c displays ONLY the current folder name
local current_dir="%F{6}%c%f"

# Prompt Assembly
PROMPT="\$(k8s_prompt_info)${status_indicator}${current_dir} \$(git_prompt_info)"

# Git Formatting
ZSH_THEME_GIT_PROMPT_PREFIX="%F{4}git:(%F{3}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{4})%f "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{1}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
