$(document).on 'turbolinks:load', ->
  sendSearchAjaxRequest = () ->
    $.ajax
      type: 'GET'
      url: '/products'
      data: query: $('#search').val()
      dataType: 'json'
      success: (response) ->
        new SearchService(response).render()

  $(document).on 'delayedkeypress', $('#search'), ->
    if $('#search').val().length > 0
      sendSearchAjaxRequest()
    else
      $('.search_dropdown').hide()
      $('.search-form .form-group').removeClass 'hover'

  $('#search').focusin ->
    $('.search-form .form-group').addClass 'hover'

  #$('#search').focusout ->
    #$('.search-form .form-group').removeClass 'hover'
