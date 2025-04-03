echo "# TODO" > todo_cleaning.md
egrep -o '\- \[.?\] [^"]+' ../precleaning_inspect.ipynb >> todo_cleaning.md
