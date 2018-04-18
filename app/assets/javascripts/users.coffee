# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.btn-sort').on 'click', ->
    $('.btn-sort').removeClass 'btn-sort-active'
    user_id = $(this).parent().data 'user-id'
    $(this).addClass 'btn-sort-active'
    sort = $(this).data 'sort'
    $.ajax
      url: "#{user_id}"
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
