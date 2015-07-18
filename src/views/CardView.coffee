class window.CardView extends Backbone.View
  className: 'card'

  template: _.template ''


  initialize: -> 
    @render()

  render: ->
    # @$el.css('background-image', 'url(img/cards/' + @model.attributes.rankName + '-' + @model.attributes.suitName + '.png)')
    @$el.children().detach()
    # @$el.attr('background-image', 'url(img/cards/' + @model.attributes.rankName + '-' + @model.attributes.suitName + '.png)');
    @$el.html (@template @model.attributes)
    @$el.addClass 'covered' unless @model.get 'revealed'

