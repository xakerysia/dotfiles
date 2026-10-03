# ---------- История ----------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY

# ---------- Автодополнение ----------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ---------- Пути ----------
export PATH=/home/rysia/.local/bin:$PATH

# ---------- Алиасы ----------
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias osu='gamemoderun ~/.local/bin/osu-wine --devserver osugatari.ru'
#alias osu='WINE=/usr/bin/wine gamemoderun ~/.local/bin/osu-wine --devserver osugatari.ru'

alias cava="cava -p ~/.config/cava/config"
alias cava1="cava -p ~/.config/cava/1"
alias cava2="cava -p ~/.config/cava/2"
alias cava3="cava -p ~/.config/cava/3"
alias cava4="cava -p ~/.config/cava/4"
alias cava5="cava -p ~/.config/cava/5"
alias cava6="cava -p ~/.config/cava/6"
alias cava7="cava -p ~/.config/cava/7"

alias ytm='yt-dlp -f "ba" -x --audio-format opus --embed-thumbnail --embed-metadata --no-mtime --convert-thumbnails jpg -o "%(title)s.%(ext)s"'
alias ytma='yt-dlp -f "ba" -x --audio-format opus --embed-thumbnail --embed-metadata --no-mtime --convert-thumbnails jpg --yes-playlist -o "%(album,playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s"'

alias ncmpcppe="(mpv http://100.86.200.54:8000 --no-video --terminal=no &); ncmpcpp --config ~/.ncmpcpp/config-eeepc; killall mpv"
alias clock='tclock -c #d8d8d8 -S'
alias tesseract='nohup ~/tesseract/tesseract2 > /dev/null 2>&1 &'
alias triangle='nohup ~/tesseract/triangle > /dev/null 2>&1 &'
# ---------- Starship ----------
eval "$(starship init zsh)"


# ============================================================
# Vi-режим + hjkl-навигация + Ctrl/Alt word-бинды
# ============================================================

# --- Включаем Vi-режим ---
bindkey -v

# --- Навигация hjkl в нормальном режиме (vicmd) ---
bindkey -a 'h' backward-char
bindkey -a 'l' forward-char
bindkey -a 'k' down-history        # вверх — предыдущая команда
bindkey -a 'j' up-history          # вниз — следующая команда

# Загружаем модуль complist для поддержки keymap menuselect
zmodload zsh/complist

# --- hjkl в меню автодополнения (menuselect) ---
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# --- Навигация по словам по Ctrl+h / Ctrl+l (Vim-style) ---
# ^H = Ctrl+h = Ctrl+Backspace в большинстве терминалов.
# Если хочешь, чтобы Ctrl+Backspace удалял слово — раскомментируй
# строки ниже и закомментируй эти две.
bindkey '^H' backward-word         # Ctrl+h → назад на слово
bindkey '^L' forward-word          # Ctrl+l → вперёд на слово

# --- История: Ctrl+p (вверх) / Ctrl+n (вниз) ---
bindkey '^P' up-history
bindkey '^N' down-history

# --- Поиск по истории: Ctrl+R (в обоих режимах) ---
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M menuselect '^R' history-incremental-search-backward

# --- Удаление слова (Ctrl+Backspace и Ctrl+W) ---
# Если переопределил ^H выше, раскомментируй:
# bindkey '^H' backward-kill-word
bindkey '^W' backward-kill-word    # Ctrl+W → удалить слово назад
bindkey '^[[3;5~' kill-word        # Ctrl+Delete → удалить слово вперёд

# --- Удаление символа ---
bindkey '^[[3~' delete-char        # Delete → удалить символ под курсором

# --- Перемещение по строкам (Ctrl+Left / Ctrl+Right) ---
bindkey '^[[1;5D' backward-word    # Ctrl+Left
bindkey '^[[1;5C' forward-word     # Ctrl+Right

# --- Home / End ---
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# --- Очистка экрана: Ctrl+Shift+L ---
bindkey '^[[1;6L' clear-screen
bindkey -M vicmd '^[[1;6L' clear-screen

# --- Быстрое переключение режимов ---
export KEYTIMEOUT=10   # 100 мс

# --- Меняем курсор в зависимости от режима (опционально) ---
# Работает в терминалах, которые поддерживают DECSCUSR.
# Alacritty поддерживает. Если не нужен — удали блок.
#function zle-keymap-select {
#  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
#    echo -ne '\e[1 q'
#  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
#    echo -ne '\e[5 q'
#  fi
#}
#zle -N zle-keymap-select
#zle-line-init() {
#  zle -K viins
#  echo -ne '\e[5 q'
#}
#zle -N zle-line-init
#echo -ne '\e[5 q'   # блочный курсор при старте
#preexec() { echo -ne '\e[5 q' }

# ---------- Плагины (важен порядок!) ----------
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

