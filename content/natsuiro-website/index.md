+++
title = "「なついろにっき。」ティザーサイト制作物語"
date = 2025-09-02
authors = ["Myxogastria0808"]
[taxonomies]
tags = ["制作日記", "ウェブサイト"]
+++

「なついろにっき。」のティザーサイトをAstroで作成しました、Myxogastria0808です。
制作時にこだわった点や工夫した点を紹介します。

### 画像の最適化

「なついろにっき。」のティザーサイトは、ウェブサイトのファーストビューにステラのキービジュアルが大きく表示されるのが特徴的なデザインになっています。
そのため、画像の最適化には特に注意を払い、表示速度の向上を図りました。
今回、Astro組み込みの[`<Picture />`コンポーネント](https://docs.astro.build/ja/guides/images/#picture-)を活用し、
複数フォーマットやサイズでのレスポンシブな画像の表示を実現しました。

以下が該当のコンポーネントの一部になります。

```
<Picture
 src={pcImage}
  formats={['webp', 'avif']}
  fallbackFormat="jpeg"
  alt="Key Visual"
  layout="full-width"
  width={pcImage.width}
  height={pcImage.height}
  priority
/>
```

<br/>
<br/>

1. `format`プロパティ (`formats={['webp', 'avif']}`)

`<source>`タグに仕使用するフォーマットの配列になります。
今回の場合は、`webp` → `avif` の順に指定されています。

2. `fallbackFormat`プロパティ (`fallbackFormat="jpeg"`)

`<img>`タグのフォールバック値として使用するフォーマットです。
今回は静止画なので、デフォルトでは`png`でしたが、サイズがあまりに大きいために
一部で問題が発生したため、`jpeg`に変更しました。

3. `priority`

`priority`属性を付与することによって、この属性を付与した`<Image />`コンポーネントまたは`<Picture />`コンポーネントでは、ブラウザに画像ををただちに読み込むように指示します。
これによって、ファーストビューの画像の遅延を抑える工夫をしています。

4. レスポンシブ対応 その1

ファーストビューの画像は、レスポンシブ対応を行っています。
Astroで画像を扱う際に、最も難しいポイントになるのがレスポンシブ対応になると思います。
(実際、私はそうでした。)

Astroでレスポンシブ画像を実装するには、まず`astro.config.mjs`で画像の設定を行う必要があります。

以下が`astro.config.mjs`の全体になります。

```js
// @ts-check
import { defineConfig } from 'astro/config';
import react from '@astrojs/react';

// https://astro.build/config
export default defineConfig({
  image: {
    responsiveStyles: true,
  },
  integrations: [react()],
});
```

以下の設定によって、`Responsive images`が有効になります。

```js
  image: {
    responsiveStyles: true,
  },
```

詳細は、以下のQiitaの記事が参考にされると良いと思います。

[Astro 5.10のResponsive Imagesはどれくらいパフォーマンスが向上するのか実測してみた](https://qiita.com/kskwtnk/items/6a12da04e38d12acded4)

先程の設定をした上で、`<Picture />`コンポーネントの`layout`プロパティに`"full-width"`を指定することによって、横幅が100%のレスポンシブ画像を実装できます。

5. レスポンシブ対応 その2

レスポンシブ対応でもう一つ工夫した点があります。

このティザーサイトでは、縦と横の画面比率に応じて、表示する画像を切り替える工夫をしています。

以下がその該当箇所になります。

```css
  /* First View Image Control */
  @media screen and (max-aspect-ratio: 1/1) {
    .key-visual-pc {
      display: none;
    }
  }
  @media screen and (min-aspect-ratio: 1/1) {
    .key-visual-mobile {
      display: none;
    }
  }
```

横幅による切り替えではなく、画面比率による切り替えを行うことによって、
スマホを横画面にした場合でも、表示の崩れが起きないように工夫しています。

以下がResponsively Appというソフトウェアで、iPhone 12 Proの表示をシミュレート？したものになります。

- スマホの縦画面を想定した画像

{{ image(path="/content/natsuiro-website/first-view1.jpeg", width=200) }}

- スマホの横画面を想定した画像

横画面でも崩れないようにしていることがわかると思います。

{{ image(path="/content/natsuiro-website/first-view2.jpeg", height=200) }}

### ローディングアニメーションの工夫

1. 残像効果？のようなものの軽減

このティザーサイトでは、ページのローディングアニメーションにもこだわりました。


ローディングアニメーションに文字が入っているのですが、
残像効果？のようなもののせいで、ローディングアニメーションが終了しても、
文字が残ってしまうように感じてしまう問題がありました。

その問題を解決するために、文字が消えるタイミングを他の要素消えるタイミングよりも
ほんの少し早くすることで、残像効果？のようなものを軽減する工夫をしました。

以下が該当のコンポーネントになります。

※クッキーを使用しているのは、毎度ロードするたびにローディングアニメーションが表示されるのを防ぐためです。
24時間でクッキーが切れ、その後はローディングアニメーションが再度表示されます。

```tsx
import { useEffect, useState, type FC } from 'react';
import Cookies from 'js-cookie';
import styles from '../styles/loading.module.css';

const Loading: FC = () => {
  const [showLoading, setShowLoading] = useState(false);
  const [showText, setShowText] = useState(false);
  const [fadeOut, setFadeOut] = useState(false);

  useEffect(() => {
    const isVisited = Cookies.get('visited');

    const time = 2000;

    if (!isVisited) {
      // show loading screen
      setShowLoading(true);
      // show text
      setShowText(true);

      // set a cookie to indicate the user has visited
      Cookies.set('visited', 'true', { expires: 1, path: '/' });

      // show loading for 2 seconds
      setTimeout(() => {
        setShowLoading(false);
      }, time);
      // start fade out after 1.8 second
      setTimeout(() => {
        setFadeOut(true);
      }, time - 200);
      // hide text after 1.78 seconds
      setTimeout(() => {
        setShowText(false);
      }, time - 220);
    }
  }, []);

  return (
    <>
      {showLoading && (
        <div className={`${styles.overlay} ${fadeOut ? styles.fadeOut : ''}`}>
          {showText && <p className={styles.title}>少女と過ごす、少し不思議な夏休み</p>}
        </div>
      )}
    </>
  );
};

export { Loading };
```

2. ロードが終わるまで蓋をして隠す

もう一つ工夫した点があります。

ローディングアニメーションの開始前に、ページの内容が一瞬表示されてしまう問題があったので、
それを解決するためにロードが開始されるまで、
ページ全体に蓋をして隠す工夫をしました。

以下が該当するコンポーネントになります。

```
---
import { Loading } from '../components/Loading.tsx';
import FirstView from '../components/FirstView.astro';
import News from '../components/News.astro';
import Story from '../components/Story.astro';
import Movie from '../components/Movie.astro';
import { Footer } from '../components/Footer.tsx';
import Layout from '../layouts/Layout.astro';
---

<Layout>
  <Loading client:load />
  <div class="overlay"></div>
  <FirstView />
  <main>
    <News />
    <Story />
    <Movie />
  </main>
  <Footer />
</Layout>

<style>
  main {
    margin: 0 auto;
    max-width: 1200px;
  }

  .overlay {
    position: fixed;
    inset: 0;
    background-color: var(--note-bg-color);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10;
    opacity: 1;
  }

  .loaded {
    display: none;
  }
</style>

<script>
  const overlay = window.document.querySelector('.overlay');

  window.addEventListener('load', () => {
    overlay?.classList.add('loaded');
  });
</script>
```

上記コンポーネントの`<div class="overlay"></div>`が蓋の役割を果たしています。

以下のJavaScriptで、ページがロードされた後に`<div class="overlay"></div>`が
`display: none`になるようにしています。

```javascript
const overlay = window.document.querySelector('.overlay');

window.addEventListener('load', () => {
  overlay?.classList.add('loaded');
});
```

結果として、初回ロード時は以下のような変遷をたどります。

{% mermaid() %}
flowchart TD
load["class=overlayのdiv要素"] --> loading["ローディングアニメーションのコンポーネント"]
loading["ローディングアニメーションのコンポーネント"] --> loaded["ページのコンテンツ"]
{% end %}

クッキーが有効な間は、以下のような変遷をたどります。

{% mermaid() %}
flowchart TD
load["class=overlayのdiv要素"] --> loaded["ページのコンテンツ"]
{% end %}

### デザイン

この作品のタイトルが なついろ"にっき。" であることから、
日記帳のようなデザインを目指しました。

特に、あらすじのセクションでは、キャラクターのサインを追加することで、
より日記帳らしい雰囲気を演出しています。

{{ image(path="/content/natsuiro-website/diary.png") }}

### おわりに

かわいらしいイラストと作品の素敵な世界観のおかげで、良い雰囲気のサイトになったと思います。

今後も情報が追加されていく予定なので、ぜひ楽しみにしていてください！