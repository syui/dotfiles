
###start-blog

```
$ git clone https://github.com/syui/blogstart

$ cd blogstart

$ ./blogstart
```

###make-theme

テーマを追加したい場合は、一連のコマンドをクリップボードにコピーし、`make-theme`を実行してください。

```
# コマンド一覧をクリップボードに保存
$ cat << EOF | pbcopy
git clone https://github.com/syui/middleman-simple-template

cd middleman-simple-template

bundle install

middleman server
EOF

# make-themeのメニューを実行する
$ ./blogstart
```

![](https://lh4.googleusercontent.com/-cqQ1oh_50Ro/VQAw2lvlIbI/AAAAAAAAAjY/AMHfSF5yWoQ/s800/%25E3%2582%25B9%25E3%2582%25AF%25E3%2583%25AA%25E3%2583%25BC%25E3%2583%25B3%25E3%2582%25B7%25E3%2583%25A7%25E3%2583%2583%25E3%2583%2588.png)

以降、新たなメニューが追加されます。

![](http://lh3.ggpht.com/-MCWn1gj49vE/VQAui13vrZI/AAAAAAAAAjE/gEeQ20VhiHg/s0/.DS_Store.png)

###recovery-theme

リカバリは、テーマを初期状態に戻すコマンドです。テーマディレクトリ削除する場合にも使えます。

###add-theme

テーマを永続的に追加したい場合は、`add-theme`を行います。プリリクエストを行いたい時は、テーマを追加した後、このメニューを実行してください。

