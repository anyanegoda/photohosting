# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  hide_and_show = (parent) ->
    parent.find('.body_edit').hide()
    parent.find('.comment_body').show()
    parent.find('.edit_comment').show()
    parent.find('.delete_comment').show()
  $('.create_comment').on 'click' , ->
    post_id = $('#post_id').val()
    user_id = $('#author_id').val()
    comment_body = $('#comment_body').val()
    $.ajax
      type: 'POST'
      url: "#{post_id}/comments"
      data: { comment: { body: comment_body, user_id: user_id } }
      dataType: "json"
      success: (data) ->
        user_email = $('#author_email').val()
        user_avatar = $('#author_avatar').val()
        $('.no-comment').remove()
        $('.comments').append("<a class='list-group-item'>
        <div class='comment_author'><img src='#{user_avatar}' class= 'img-circle' height='50' width='50'></img><span> #{user_email}</span><span class='comment-date'>#{data.created_at}</span></div>
        <div class='comment_body inline' id='comment_body_#{data.comment.id}'>#{data.comment.body}</div>
        <textarea class='body_edit' hidden>
        <input class='comment_id' hidden value='#{data.comment.id}'>
        <button class='btn btn-default delete_comment glyphicon glyphicon-trash icon red float-right'></button>
        <button class='btn btn-default edit_comment glyphicon glyphicon-pencil icon float-right'></button>
        </a>")
        $('#comment_body').val('')
      error: (data) ->
        alert('Нельзя отправлять пустой комментарий. Пожалуйста, введите текст в поле комментария.')
  $(document).on 'click', '.edit_comment', ->
    $parent = $(this).parent()
    $parent.find('.comment_body').hide()
    $parent.find('.body_edit').show()
    value = $parent.find('.comment_body').html()
    $parent.find('.body_edit').val(value)
    $parent.append("<button class='btn btn-default update_comment glyphicon glyphicon-ok icon green'></button>
    <button class='btn btn-default cancel_update glyphicon glyphicon-remove icon red'></button>")
    $parent.find('.delete_comment').hide()
    $(this).hide()
  $(document).on 'click', '.cancel_update', ->
    $parent = $(this).parent()
    hide_and_show($parent)
    $parent.find('.update_comment').remove()
    $(this).remove()
  $(document).on 'click', '.update_comment', ->
    $parent = $(this).parent()
    $button = $(this)
    post_id = $('#post_id').val()
    $comment_id = $parent.find('.comment_id').val()
    $updated_comment_body = $parent.find('.body_edit').val()
    $.ajax
      type: 'PUT'
      url: "#{post_id}/comments/#{$comment_id}"
      data: { comment: { body: $updated_comment_body } }
      dataType: "json"
      success: (data) ->
        hide_and_show($parent)
        $("#comment_body_#{$comment_id}")[0].innerHTML = $updated_comment_body
        $parent.find('.cancel_update').remove()
        $button.remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
  $(document).on 'click', '.delete_comment', ->
    $parent = $(this).parent()
    debugger
    post_id = $('#post_id').val()
    comment_id = $parent.find('.comment_id').val()
    $.ajax
      type: 'DELETE'
      url: "#{post_id}/comments/#{comment_id}"
      data: { comment: { id: comment_id } }
      dataType: "json"
      success: (data) ->
        $parent.remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
