for d in ./*; do
  if [[ -d "${d}/.git" ]]; then
    echo "updating ${d}"
    cd $d
    git pull
    cd -
  fi
done
