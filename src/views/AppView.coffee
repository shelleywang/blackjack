class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('dealerHand').stand() 
      dealerScore = @model.get('dealerHand').scores().reduce((a,b)-> if a > b then a else b) 
      playerScore = @model.get('playerHand').scores().reduce((a,b)-> if a > b then a else b)  
      if dealerScore > playerScore and dealerScore < 22
        alert "Dealer wins with #{dealerScore}"
      else 
        alert "You win with #{playerScore}"


  initialize: ->
    clicked = false
    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    # @$('.player-hand-container').css 'position', 'bottom'

