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

  $('#open-collection-modal').on 'click', ->
    $('#add-to-collection').addClass 'visible'

  $('#add-to-collection .close-modal').on 'click', ->
    $('#add-to-collection').removeClass 'visible'

  $('#create-collection').on 'click', ->
    $('#new-collection-modal').addClass 'visible'

  $('#back-to-collections').on 'click', ->
    $('#new-collection-modal').removeClass 'visible'

  $('#save-collection').on 'click', ->
    $collection_name = $('#collection-title').val()
    collection_description = $('#collection-description').val()
    if $collection_name == ''
      $('.alert').remove()
      response = "<div class='alert alert-danger alert-dismissible fade in'>
          <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
          Нельзя создать коллекцию без имени
        </div>"
      $('#add-to-collection').prepend(
        $(response).hide().fadeIn()
      )
      #alert('Нельзя создать коллекцию без имени')
    else
      $.ajax
        url: '/collections'
        type: "POST"
        data: { collection: { name: $collection_name, description: collection_description } }
        success: (data) ->
          $collection_id = data.collection_id
          photo_id = $('#create-collection').data 'photo-id'
          $.ajax
            url: '/collections_photos/create'
            type: "POST"
            data: { collections_photo: { collection_id: $collection_id, photo_id: photo_id } }
            success: ->
              $('.alert').remove()
              $('#collection-title').val('')
              $('#collection-description').val('')
              response = "<div class='alert alert-success alert-dismissible fade in'>
                  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
                  Фото успешно добавлено в коллекцию
                </div>"
              $('#add-to-collection').prepend(
                $(response).hide().fadeIn()
              )
              image = $('#create-collection').data 'current-image'
              $('.collection-container').prepend("
                <button type='button' class='add-to-collection choose-collection remove-from-collection'
                  data-collection-id='#{$collection_id}'
                  data-current-image='#{image}'
                  style='background: url('#{image}') center'>
                  <div class='collection-overlay visible'></div>
                  <div class='choose-collection-text'>
                    <p class='photo-count'>1 фото</p>
                    <span class='collection-plus collection-sign' hidden><i class='fa fa-plus'></i></span>
                    <span class='collection-minus collection-sign'><i class='fa fa-minus'></i></span>
                    <span>#{$collection_name}</span>
                  </div>
                </button>
              ")
              $('#new-collection-modal').removeClass 'visible'
            error: ->
              $('.alert').remove()
              response = "<div class='alert alert-danger alert-dismissible fade in'>
                  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
                  Не удалось добавить фото
                </div>"
              $('#add-to-collection').prepend(
                $(response).hide().fadeIn()
              )
        error: (data) ->
          $('.alert').remove()
          response = "<div class='alert alert-success alert-dismissible fade in'>
              <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
              #{data.responseJSON.error}
            </div>"
          $('#add-to-collection').prepend(
            $(response).hide().fadeIn()
          )

  $('.choose-collection').on 'click', ->
    collection_id = $(this).data 'collection-id'
    photo_id = $('#create-collection').data 'photo-id'
    $this = $(this)
    if $(this).hasClass 'remove-from-collection'
      $.ajax
        url: '/collections_photos/delete'
        type: "POST"
        data: { collection_id: collection_id, photo_id: photo_id }
        success: ->
          image = $this.data 'last-image'
          $this.children('.choose-collection-text').children('.collection-plus').show()
          $this.children('.choose-collection-text').children('.collection-minus').hide()
          $this.children('.collection-overlay').removeClass 'visible'
          $this.removeClass 'remove-from-collection'
          count = parseInt($this.children('.choose-collection-text').children('.photo-count').html()) - 1
          $this.children('.choose-collection-text').children('.photo-count').html(count + ' фото')
          if count > 0
            $this.css('background': "url('#{image}') center")
          else
            $this.css('background': "#bbb")
          $('.alert').remove()
          response = "<div class='alert alert-success alert-dismissible fade in'>
              <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
              Фото успешно удалено из коллекции
            </div>"
          $('#add-to-collection').prepend(
            $(response).hide().fadeIn()
          )
        error: ->
          $('.alert').remove()
          response = "<div class='alert alert-danger alert-dismissible fade in'>
              <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
              Не удалось добавить фото
            </div>"
          $('#add-to-collection').prepend(
            $(response).hide().fadeIn()
          )
    else
      $.ajax
        url: '/collections_photos/create'
        type: "POST"
        data: { collections_photo: { collection_id: collection_id, photo_id: photo_id } }
        success: ->
          image = $this.data 'current-image'
          $this.children('.choose-collection-text').children('.collection-plus').hide()
          $this.children('.choose-collection-text').children('.collection-minus').show()
          $this.children('.collection-overlay').addClass 'visible'
          $this.addClass 'remove-from-collection'
          count = parseInt($this.children('.choose-collection-text').children('.photo-count').html()) + 1
          $this.children('.choose-collection-text').children('.photo-count').html(count + ' фото')
          $this.css('background': "url('#{image}') center")
          $('.alert').remove()
          response = "<div class='alert alert-success alert-dismissible fade in'>
              <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
              Фото успешно добавлено в коллекцию
            </div>"
          $('#add-to-collection').prepend(
            $(response).hide().fadeIn()
          )
        error: ->
          $('.alert').remove()
          response = "<div class='alert alert-danger alert-dismissible fade in'>
              <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
              Не удалось добавить фото
            </div>"
          $('#add-to-collection').prepend(
            $(response).hide().fadeIn()
          )

  $('#download-count').on 'click', ->
    photo_id = $('#download-count').data 'photo-id'
    $.ajax
      url: '/photos/download'
      type: "POST"
      data: { photo_id: photo_id }
      success: (data) ->
        d = data.downloads
        debugger
        $('.download-item').html data.downloads
      error: ->
        $('.alert').remove()
        response = "<div class='alert alert-danger alert-dismissible fade in'>
            <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
            Не удалось загрузить изображение
          </div>"
        $('body').prepend(
          $(response).hide().fadeIn()
        )

  $(document).click (event) ->
    if !$(event.target).closest('.add-to-collection-wrapper, #open-collection-modal, .alert').length
      $('#add-to-collection').removeClass 'visible'
