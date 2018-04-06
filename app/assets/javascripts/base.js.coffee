# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

getKlassRating = ->
  $.ajax
    method: 'GET'
    url: window.location.href
    dataType: 'json'

getKlassRatingPercentage = (rating) ->
  starTotal = 5
  starPercentage = rating / starTotal * 100
  starPercentageRounded = "#{(Math.round(starPercentage / 10) * 10)}%"
  $(".klass-rating .stars-inner").css('width', starPercentageRounded)

$(document).on 'turbolinks:load', ->
  if ($('.klass-rating').length > 0)
    new Promise((resolve, reject) ->
      resolve getKlassRating()
      return
    ).then (data) ->
      getKlassRatingPercentage(data.rating)
      return
