# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  f_acc = ->
    #скрываем все кроме того, что должны открыть
    $('#accordeon .btn-sort-items').not($(this).next()).slideUp 1000
    # открываем или скрываем блок под заголовоком, по которому кликнули
    $(this).next().slideToggle 1000

  $(document).ready ->
    #прикрепляем клик по заголовкам acc-head
    $('#accordeon .btn-sort-view').on 'click', f_acc

  $('.btn-sort').on 'click', ->
    $('.btn-sort').removeClass 'btn-sort-active'
    $(this).addClass 'btn-sort-active'
    sort = $(this).data 'sort'
    $.ajax
      url: '/index'
      type: "POST"
      data: { sort: sort }
      success: (data) ->
        data.photos
        $('.photo').remove()
        $.each data.photos, (index, value) ->
          debugger
          $('#photos').append("
            <div class='photo'>
              <p>#{value.views}</p>
              <a target='_blank' href='#{value.image.url}'><img src='#{value.image.thumb.url}' alt='Image'></a>
            </div>
          ")
