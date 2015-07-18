class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="cardcount"></div>  
    <div class="cardcount2"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('dealerHand').stand()  
      dealerScoreArray = @model.get('dealerHand')
      playerScoreArray = @model.get('playerHand')
      dealerScore = dealerScoreArray.scores().sort((a,b)-> b-a)
      playerScore = playerScoreArray.scores().sort((a,b)-> b-a)
      if playerScore[0] <=21 then playerScore = playerScore[0] else playerScore = playerScore[1] 
      if dealerScore[0] <=21 then dealerScore = dealerScore[0] else dealerScore = dealerScore[1] 
      that = @
      alertMessage = () ->
        if 22 > dealerScore > playerScore
          if dealerScoreArray.models.length is 2 and dealerScore is 21 
            confirm "Dealer wins with BLACKJACK, Do you want to play another hand?"    
          else 
            confirm "Dealer wins with #{dealerScore}, Do you want to play another hand?"
        else if dealerScore is playerScore
          confirm "You tied with #{dealerScore}, Do you want to play another hand?"
        else  
          if playerScoreArray.models.length is 2 and playerScore is 21 
            confirm "You win with BLACKJACK, Do you want to play another hand?"    
          else 
            confirm "You win with #{playerScore}, Do you want to play another hand?"
        
        appstate = {
          deck: that.model.get 'deck'
        }
        localStorage.setItem 'appState', JSON.stringify(appstate)
        window.location.reload()
      setTimeout alertMessage, 200


  initialize: ->
    @render()


  render: ->
    cards = @model.get 'deck'
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

    @$('.cardcount2').append "<br/><p>Cards left #{cards.length}</p>"
