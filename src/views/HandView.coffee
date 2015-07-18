class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()

    @render()

    @optimalScore = 0

  render: ->
    @$el.children().detach()
    @$el.html @template @collection

    @$el.append @collection.map (card) ->
      new CardView(model: card).$el.css('background-image', 'url(img/cards/'+ card.attributes.rankName + '-' + card.attributes.suitName + '.png)')

    @optimalScore = @collection.scores()[0];
    if @collection.scores()[1] <= 21 and @collection.hasAce()
      @optimalScore = @collection.scores()[1];

    @$('.score').text @optimalScore






