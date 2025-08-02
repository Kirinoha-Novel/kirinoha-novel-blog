+++
title = "「なついろにっき。」制作ブログ 爆誕"
date = 2025-06-12
authors = ["Myxogastria0808"]
[taxonomies]
tags = ["制作日記", "スクリプト"]
+++

「なついろにっき。」制作ブログをzolaで爆速で作成しました、Myxogastria0808です。
`Shortcodes`も複数用意したので、表現が豊かな数々のブログがこれから作成されることでしょう。
利用できる記法を様々載せています。

# h1

## h2

### h3

#### h4

##### h5

###### h6

アリスは川辺でおねえさんのよこにすわって、なんにもすることがないのでとても退屈（たいくつ）しはじめていました。一、二回はおねえさんの読んでいる本をのぞいてみたけれど、そこには絵も会話もないのです。「絵や会話のない本なんて、なんの役にもたたないじゃないの」とアリスは思いました。そこでアリスは、頭のなかで、ひなぎくのくさりをつくったら楽しいだろうけれど、起きあがってひなぎくをつむのもめんどくさいし、どうしようかと考えていました（といっても、昼間で暑いし、とってもねむくて頭もまわらなかったので、これもたいへんだったのですが）。そこへいきなり、ピンクの目をした白うさぎが近くを走ってきたのです。

それだけなら、そんなにめずらしいことでもありませんでした。さらにアリスとしては、そのうさぎが「どうしよう！　どうしよう！　ちこくしちゃうぞ！」とつぶやくのを聞いたときも、それがそんなにへんてこだとは思いませんでした（あとから考えてみたら、これも不思議に思うべきだったのですけれど、でもこのときには、それがごく自然なことに思えたのです）。でもそのうさぎがほんとうに、チョッキのポケットから懐中時計（かいちゅうどけい）をとりだしてそれをながめ、そしてまたあわててかけだしたとき、アリスもとびあがりました。というのも、チョッキのポケットなんかがあるうさぎはこれまで見たことがないし、そこからとりだす時計をもって

# note

{% note() %}
これは note です。
{% end %}

{% tip() %}
これは tip です。
{% end %}

{% important() %}
これは important です。
{% end %}

{% warning() %}
これは warning です。
{% end %}

{% caution() %}
これは caution です。
{% end %}

# Tips

Link

筑波大学: [筑波大学 HP](https://www.tsukuba.ac.jp/)

Nomal

**Bold**

_Italic_

~Strikethrough~

- Bullet List
  - Bullet List
    - Bullet List
- Bullet List

1. Numbered List
   1. Numbered List
      1. Numbered List
2. Numbered List

- [ ] checkbox
- [x] checkbox

> Blockquote

Horizontal

---

katex

$$
\frac{dy}{dx} + p(x) y^2 + q(x) y + r(x) = 0
$$

emoji

:smile:

code block

```rs
fn main() {
    println!("Hello, world!");
}
```

colocation

program file sample: [here](sample.rs).

# mermaid

{% mermaid() %}
flowchart LR
rdb["PostgreSQL (RDB)"] <--> server["server (main)"]
graphdb["Neo4j (GraphDB)"] <--> server["server (main)"]
meilisearch["Meilisearch (検索エンジン)"] <--> server["server (main)"]
cloudflare["Cloudflare R2 (画像保存)"] <--> image-server["image-server (画像専用)"]
server["server (main)"] <--> client["client"]
image-server["image-server (画像専用)"] <--> client["client"]
{% end %}

# image

image with caption

{{ image(path="/content/sample/image.jpg", width=1000, height=200, caption="captionの例") }}

custom image

{{ image(path="/content/sample/image.jpg", width=100, height=200) }}

image (for vertical image)

{{ image(path="/content/sample/image.jpg", height=200) }}

image (for horizontal image: pattern1)

{{ image(path="/content/sample/image.jpg") }}

image (for horizontal image: pattern2)

{{ image(path="/content/sample/image.jpg", width=300) }}
