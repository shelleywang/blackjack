class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'


  initialize: ->

    @collection.on 'add remove change', => @render()

    @collection.on 'stand', =>
      
      score = @collection.scores()
      if score[0] isnt score[1]
        if score[0] > score[1] and score[0] <= 21
          @$('.score').text "#{score[0]}"
        else
          @$('.score').text "#{score[1]}"
      else
        @$('.score').text "#{score[0]}"

    @collection.on 'endHand', =>
      window.location.reload()


    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    score = @collection.scores()
    if not @collection.isDealer  
      if score[0] isnt score[1] then @$('.score').text "#{score[0]} or #{score[1]}" else @$('.score').text score[0]
    else
      @$('.score').text 'hidden'

