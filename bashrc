if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export SYSTEMD_PAGER=

if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

. "$HOME/.cargo/env"

export PATH=$PATH:~/.config/emacs/bin:.
alias e="emacsclient -nw"
export EDITOR="emacsclient -nw"
export VISUAL="emacsclient"
export PYTHONDONTWRITEBYTECODE=1
alias :q='echo "E37: No write since last change (:q! overrides)"'
alias :q!='exit'
alias sed11q='sed 11q'
alias sxiv=xdg-open
alias zathura=xdg-open
alias mkdir='mkdir -vp'
alias cp='cp -v'
alias bc='bc -ql'
alias grep='grep --color'
alias ls='ls --color'
alias manim='manim --media_dir /tmp/manim'
alias top="top -e m -E m -u \!root -d 1"
alias todo="emacsclient -nw ~/todo.org"

extract() {
    while [ "$1" ]; do
        archive="$1"

        echo "Extracting '$archive'..."

        case "$archive" in
        *.zpaq)
            zpaq extract "$archive"
            ;;
        *.tar.zst)
            tar --zstd -xf "$archive"
            ;;
        *.tar.bz2 | *.tbz2)
            tar xjf "$archive"
            ;;
        *.tar.gz | *.tgz)
            tar xzf "$archive"
            ;;
        *.tar.xz)
            tar -xf "$archive"
            ;;
        *.bz2)
            # Preserve original archive
            bunzip2 -k "$archive"
            ;;
        *.rar)
            unrar x "$archive"
            ;;
        *.gz)
            # Preserve original archive
            gunzip -k "$archive"
            ;;
        *.tar)
            tar xf "$archive"
            ;;
        *.zip)
            unzip "$archive"
            ;;
        *.Z)
            uncompress "$archive"
            ;;
        *.7z)
            7z x "$archive"
            ;;
        *)
            echo "extract: '$archive' cannot be extracted via extract()"
            ;;
        esac

        shift
    done
}

compress() {
    if [ $# -lt 2 ]; then
        echo "Usage: compress <archive-name> <file(s)/dir(s)>"
        return 1
    fi

    archive="$1"
    shift

    if [ -e "$archive" ]; then
        echo "compress: '$archive' already exists, aborting to avoid overwrite"
        return 1
    fi

    echo "Creating archive '$archive'..."

    case "$archive" in
    *.tar.zst)
        tar --zstd -cf "$archive" "$@"
        ;;
    *.tar.bz2 | *.tbz2)
        tar cjf "$archive" "$@"
        ;;
    *.tar.gz | *.tgz)
        tar czf "$archive" "$@"
        ;;
    *.zip)
        zip -r "$archive" "$@"
        ;;
    *.7z)
        7z a "$archive" "$@"
        ;;
    *.rar)
        rar a "$archive" "$@"
        ;;
    *)
        echo "compress: filetype not recognized for '$archive'"
        return 1
        ;;
    esac
}

base64targz() {
    tar -czf - "$@" | base64
}

unbase64targz() {
    base64 -d | tar -xzf -
}

base64tarzst() {
    tar -I 'zstd --ultra -22 -T0' -cf - "$@" | base64
}

unbase64tarzst() {
    base64 -d | tar -I 'zstd -d' -xf -
}

[ -f "/home/dan/.ghcup/env" ] && . "/home/dan/.ghcup/env" # ghcup-env
alias ghc='ghc -i.'
alias ghci='ghci -i.'
alias runghc='runghc -i.'
alias hinfo='hoogle --info'

shopt -s autocd

eval "$(starship init bash)"
