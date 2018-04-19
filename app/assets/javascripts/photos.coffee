# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  f_acc = ->
    #скрываем все кроме того, что должны открыть
    $('#accordeon .btn-sort-items').not($(this).next()).slideUp 1000
    # открываем или скрываем блок под заголовоком, по которому кликнули
    $(this).next().slideToggle 1000
    #

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
          $('#photos').append("
            <div class='photo'>
              <p>#{value.views}</p>
              <a target='_blank' href='#{value.image.url}'><img src='#{value.image.thumb.url}' alt='Image'></a>
            </div>
          ")

  $('#create-collection').on 'click', ->
    $('#new-collection-modal').slideDown 1000

  $('#back-to-collections').on 'click', ->
    $('#new-collection-modal').slideUp 1000

  $('#save-collection').on 'click', ->
    collection_name = $('#collection-title').val()
    collection_description = $('#collection-description').val()
    $.ajax
      url: '/collections'
      type: "POST"
      data: { collection: { name: collection_name, description: collection_description } }
      #data: { photo_id: photo_id }
      success: (data) ->
        collection_id = data.collection_id
        photo_id = $('#create-collection').data 'photo-id'
        $.ajax
          url: '/collections_photos/create'
          type: "POST"
          data: { collections_photo: { collection_id: collection_id, photo_id: photo_id } }
          success: ->
            alert('Фото успешно добавлено в коллекцию')
          error: ->
            alert('Не удалось добавить фото')
      error: (data) ->
        alert('Не удалось создать коллекцию.')


  $('.choose-collection').on 'click', ->
    collection_id = $(this).data 'collection-id'
    photo_id = $('#create-collection').data 'photo-id'
    $.ajax
      url: '/collections_photos/create'
      type: "POST"
      data: { collections_photo: { collection_id: collection_id, photo_id: photo_id } }
      success: ->
        alert('Фото успешно добавлено в коллекцию')
      error: ->
        alert('Не удалось добавить фото')
