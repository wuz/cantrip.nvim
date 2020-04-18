command! -bang -nargs=? -complete=dir Owners ! git blame --line-porcelain % | sed -n 's/^author //p' | sort | uniq -c | sort -rn
