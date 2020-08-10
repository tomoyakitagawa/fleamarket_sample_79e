$(document).on('turbolinks:load', function(){
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="hidden-field" type="file"
                    name="item[item_images_attributes][${index}][image]"
                    id="item_item_images_attributes_${index}_image">
                  </div>`;
    return html;
  }

  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<div class="preview-box">
                    <div class="upper-box">
                      <img data-index="${index}" src=${url}>
                      <div class="delete-btn">削除</div>
                    </div>
                  </div>`;
    return html;
  }

  //-----プレビュー部分とlabel部分のwidth調整-------
  //label-contentの直前に配置されている要素(今回はdiv class="prev-content")を取得する
  const prevContent = $('.label-content').prev();
  function setLabel(count) {
    //プレビューが5個あったらラベルを隠す
    if (count == 5) { 
      $('.label-content').hide();
    } else {
      //プレビューが4個以下の場合はラベルを表示
      $('.label-content').show();
      //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定(prev-contentのwidthを取って、大枠(width:620px)から引き算する)
      labelWidth = (620 - parseInt($(prevContent).css('width')));  //parseIntは文字列を整数に変換するjavascriptの関数
      $('.label-content').css('width', labelWidth);
    }
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

  // 商品情報編集時に使用。既に使われているindexを除外
  // 既に使われているindexを確認。使われている最後のindexの番号を取得
  lastIndex = $('.js-file_group:last').data('index');
  // 配列fileIndexから使われているindexを削除する。0は始点を配列の最初からという意味
  fileIndex.splice(0, lastIndex);
  // 画像の下にあるチェックボックスを非表示にする
  $('.hidden-destroy').hide();

  //-----inputフォーム関連------
  $('.post__drop__box__container').on('change', '.hidden-field', function(e) {
    // thisはイベントの発生源となった要素を取得できる
    // inputフォームを押した要素の親要素のindex番号を取得して定義する
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 画像用のinputに変更があった際、該当indexを持ったimgタグが存在するかどうかで条件分岐をする
    // imgタグが存在すれば(既存画像の変更)そのsrcを変更後の画像のurlで置き換えます。
    // imgタグが存在しなければ(新規画像の追加)buildImg関数を使ってimgタグを生成します。
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $('.prev-content').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('.hidden-content').append(buildFileField(fileIndex[0]));
      //label要素のfor属性も変更する
      $('.label-box').attr({for: `item_item_images_attributes_${fileIndex[0]}_image`});
      //shiftメソッドで配列fileIndexの先頭の要素を取り除く
      fileIndex.shift();
      // pushメソッドで配列fileIndexに対して、末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
      //プレビューの数を取得
      let count = $('.preview-box').length;
      setLabel(count);
    }
  });

  //-----入力した画像(プレビューに載っている画像)を削除した時------
  $('.post__drop__box__container').on('click', '.delete-btn', function() {
    // まずは、削除ボタンを押した際に、該当indexが振られたチェックボックスへチェックを入れる処理
    // 削除ボタンを押したimg要素のindex番号を取得して定義する
    const targetIndex = $(this).prev().data('index')
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すれば、つまりtrueなら、チェックを入れる
    // hiddenCheckに、propメソッドを使用して()の中に合致するプロパティを取得する
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    // 次に削除ボタンを押した要素の親要素含め削除
    $(this).parent().parent().remove();
    $(`div[data-index="${targetIndex}"]`).remove();

    // 画像入力するためのinputフォームが0個にならないようにする
    if ($('.hidden-field').length == 0) $('.hidden-content').append(buildFileField(fileIndex[0]));

    //プレビューの数を取得
    let count = $('.preview-box').length;
    setLabel(count);
  });
});