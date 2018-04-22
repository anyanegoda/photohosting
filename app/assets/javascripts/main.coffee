# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.mobile-menu-button').on 'click', ->
    $('.mobile-menu-container').addClass 'visible'
  $('.close-mobile-menu').on 'click', ->
    $('.mobile-menu-container').removeClass 'visible'
