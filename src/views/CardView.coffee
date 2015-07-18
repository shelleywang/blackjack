class window.CardView extends Backbone.View
  className: 'card'

  template: _.template ''


  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    currentFace = @model.attributes.rankName
    currentRank = @model.attributes.suitName
    @$el.css 'background-image', "url(img/cards/#{currentFace}-#{currentRank}.png)"
    @$el.css 'background-image', 'url(img/card-back.png)' unless @model.get 'revealed'

