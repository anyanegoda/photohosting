# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  hide_and_show = (parent) ->
    parent.find('.photos_body_edit').removeClass "visible"
    parent.find('.photos_comment_body').show()
    parent.find('.edit_photos_comment').show()
    parent.find('.delete_photos_comment').show()
  $('.create_photos_comment').on 'click' , ->
    photo_id = $('#photo_id').val()
    user_id = $('#author_id').val()
    photos_comment_body = $('#photos_comment_body').val()
    $.ajax
      type: 'POST'
      url: "#{photo_id}/photos_comments"
      data: { photos_comment: { body: photos_comment_body, user_id: user_id } }
      dataType: "json"
      success: (data) ->
        debugger
        user_email = $('#author_email').val()
        user_avatar = $('#author_avatar').val()
        $('.no-comment').remove()
        $('.photos_comments').append("<div class='comment-body'>
        <div class='photos_comment_author'><img src='#{user_avatar}' class= 'img-circle'></img></div>
        <div class='photos_comment-text'><span>#{user_email}</span><span class='photos_comment-date'>#{data.created_at}</span>
        <pre class='photos_comment_body inline pre-custom' id='photos_comment_body_#{data.comment.id}'>#{data.comment.body}</pre>
        <textarea class='custom-textarea photos_body_edit' hidden></textarea>
        <input class='photos_comment_id' hidden value='#{data.comment.id}'>
        <button class='btn btn-default delete_photos_comment glyphicon glyphicon-trash icon red float-right'></button>
        <button class='btn btn-default edit_photos_comment glyphicon glyphicon-pencil icon float-right'></button></div>
        </div>")
        $('#photos_comment_body').val('')
      error: (data) ->
        alert('Нельзя отправлять пустой комментарий. Пожалуйста, введите текст в поле комментария.')
  $(document).on 'click', '.edit_photos_comment', ->
    $parent = $(this).parent()
    $parent.find('.photos_comment_body').hide()
    $parent.find('.photos_body_edit').addClass "visible"
    value = $parent.find('.photos_comment_body').html()
    $parent.find('.photos_body_edit').val(value)
    $parent.append("<button class='btn btn-default update_photos_comment glyphicon glyphicon-ok icon green'></button>
    <button class='btn btn-default cancel_photos_update glyphicon glyphicon-remove icon red'></button>")
    $parent.find('.delete_photos_comment').hide()
    $(this).hide()
  $(document).on 'click', '.cancel_photos_update', ->
    $parent = $(this).parent()
    hide_and_show($parent)
    $parent.find('.update_photos_comment').remove()
    $(this).remove()
  $(document).on 'click', '.update_photos_comment', ->
    $parent = $(this).parent()
    $button = $(this)
    photo_id = $('#photo_id').val()
    $photos_comment_id = $parent.find('.photos_comment_id').val()
    $updated_photos_comment_body = $parent.find('.photos_body_edit').val()
    $.ajax
      type: 'PUT'
      url: "#{photo_id}/photos_comments/#{$photos_comment_id}"
      data: { photos_comment: { body: $updated_photos_comment_body } }
      dataType: "json"
      success: (data) ->
        hide_and_show($parent)
        $("#photos_comment_body_#{$photos_comment_id}")[0].innerHTML = $updated_photos_comment_body
        $parent.find('.cancel_photos_update').remove()
        $button.remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
  $(document).on 'click', '.delete_photos_comment', ->
    $parent = $(this).parent()
    photo_id = $('#photo_id').val()
    photos_comment_id = $parent.find('.photos_comment_id').val()
    $.ajax
      type: 'DELETE'
      url: "#{photo_id}/photos_comments/#{photos_comment_id}"
      data: { photos_comment: { id: photos_comment_id } }
      dataType: "json"
      success: (data) ->
        $parent.parent().remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
