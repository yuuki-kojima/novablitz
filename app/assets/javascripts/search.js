$(document).on('turbolinks:load', function() {
  function buildHTML(card){

    var html = `<li class="card">
<img alt="Acolyte of Halos" data-card-id="${card.id}" src="${card.image}">
</li>`
    return html;
  }

  function ajaxSearch(){
    var input = obj.val();
    var aspects = [];
    $.each($('.aspect .is_active'), function(i, value) {
      aspects.push(value.innerText);
    });
    var types = [];
    $.each($('.type .is_active'), function(i, value) {
      types.push(value.innerText);
    });
    var costs = [];
    $.each($('.cost .is_active'), function(i, value) {
      if(value.innerText == "ALL"){
        costs.push(value.innerText);
      }else{
        costs.push(Number(value.innerText));
      }
    });
    var rarites = [];
    $.each($('.rarity .is_active'), function(i, value) {
      rarites.push(value.innerText);
    });

    if(input != '' || aspects.length != 0 || types.length != 0 || costs.length != 0 || rarites != 0){
      $.ajax({
        type: 'GET',
        url: '/search',
        data: { keyword: input, aspects: aspects, types: types, costs:costs, rarites:rarites},
        dataType: 'json'
      })
      .done(function(cards) {
        $("#search-result").empty();
        if (cards.length !== 0) {
          cards.forEach(function(card){
            var html = buildHTML(card);
            $(html).appendTo('#search-result');
          });
        }
      })
      .fail(function(){
        alert('カード検索に失敗しました。');
      })
    }else{
      $("#search-result").empty();
    }
  }

  var obj = $('#search-field');
  obj.val('');
  obj.on("keyup", function() {
    ajaxSearch();
  });

  var aspect_obj = $('.aspect li');
  aspect_obj.on("click", function(){
    $(this).toggleClass('is_active');
    $('.aspect .all').removeClass('is_active');
    if($('.aspect .is_active').length == 0){
      $('.aspect .all').addClass('is_active')
    }
    ajaxSearch();
  });

  var type_obj = $('.type span');
  type_obj.on("click", function(){
    $(this).toggleClass('is_active');
    $('.type .all').removeClass('is_active');
    if($('.type .is_active').length == 0){
      $('.type .all').addClass('is_active')
    }
    ajaxSearch();
  });

  var cost_obj = $('.cost span');
  cost_obj.on("click", function(){
    $(this).toggleClass('is_active');
    $('.cost .all').removeClass('is_active');
    if($('.cost .is_active').length == 0){
      $('.cost .all').addClass('is_active')
    }
    ajaxSearch();
  });

  var rarity_obj = $('.rarity span');
  rarity_obj.on("click", function(){
    $(this).toggleClass('is_active');
    $('.rarity .all').removeClass('is_active');
    if($('.rarity .is_active').length == 0){
      $('.rarity .all').addClass('is_active')
    }
    ajaxSearch();
  });

  var all_obj = $('.search .all');
  all_obj.on("click", function(){
    $(this).addClass('is_active');
    $(this).siblings().removeClass('is_active');
    ajaxSearch();
  });

  $(document).on("click", ".card",function(){
      // $("#popup").empty();
      var card_id = $(this).data('cardId');

      $.ajax({
        type: 'GET',
        url: '/show',
        data: { id: card_id},
        dataType: 'json'
      })
      .done(function(card) {
        if(card.text_jp != null){
          var card_text = card.text_jp;
        }else{
          var card_text = card.text;
        }
        $(".card-info__image img").attr('src', card.image);
        $('.card-info-right__name p').text(card.name);
        $('.card-info-right__aspect p').text(`Aspect：${card.aspect}`);
        $('.card-info-right__type p').text(`Type：${card.type}`);
        if(card.sub_type !== ''){
        $('.card-info-right__sub-type p').text(`Race：${card.sub_type}`);
        }else{
        $('.card-info-right__sub-type p').text("");
        }
        $('.card-info-right__text p').text(card_text);
        $('.popup').show();
      })
      .fail(function(){
        alert('カード検索に失敗しました。');
      })
  });

  $(document).on("click", ".close", function(){
    $('.popup').hide();
  });

});
