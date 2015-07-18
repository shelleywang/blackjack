class window.CardView extends Backbone.View
  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'
  # currentFace: "#{rankName}-#{suitName}" 
  # src="../../img/cards/#{rankName}-#{suitName}.png/
  template: _.template ''


  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    currentFace = @model.attributes.rankName
    currentRank = @model.attributes.suitName
    @$el.css 'background-image', "url(img/cards/#{currentFace}-#{currentRank}.png)"
    # @$el.addClass 'covered' unless @model.get 'revealed'
    @$el.css 'background-image', 'url(img/card-back.png)' unless @model.get 'revealed'

