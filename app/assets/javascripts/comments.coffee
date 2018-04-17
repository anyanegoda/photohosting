# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.create_comment').on 'click' , ->
    post_id = $('#post_id').val()
    user_id = $('#author_id').val()
    comment_body = $('#comment_body').val()
    debugger
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
