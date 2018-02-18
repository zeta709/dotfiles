## simple server for markdown
mdserver() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: mdserver file.md"
    return
  fi

  local TMP="$HOME/tmp"
  mkdir -p "$TMP" || return
  local CSS="markdown_pandoc.css"
  if [ ! -r "$TMP/$CSS" ]; then
    (
    cd "$TMP" || return
    if [ ! -r markdown.css ]; then
      curl -O "https://guides.github.com/components/primer/markdown.css" || return
    fi
    sed 's/.markdown-//g; s/overflow *: *hidden *;/overflow: auto;/g' markdown.css > "$CSS" || return
    )
  fi

  local OPT="-f markdown_github -t html5 --self-contained --standalone"
  pandoc "${=OPT}" --css "$TMP/$CSS" -o "$TMP/index.html" -- "$1" || return
  (cd "$TMP" && python3 -m http.server)
}
