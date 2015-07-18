class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    if not window.localStorage.appState?
      @add _([0...52]).shuffle().map (card) ->
        new Card
          rank: card % 13
          suit: Math.floor(card / 13)
    else if JSON.parse(window.localStorage.appState).deck.length < 15
      @add _([0...52]).shuffle().map (card) ->
        new Card
          rank: card % 13
          suit: Math.floor(card / 13)
      alert 'shuffling deck'    
    else
      deck = JSON.parse(window.localStorage.appState)
      @add deck.deck 
#removes last card from this collection -- Deck
  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

