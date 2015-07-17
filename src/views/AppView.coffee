class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()
      if !@flipppedOnce
        @model.get('dealerHand').first().flip()
        @flipppedOnce = true
      
      # @checkScore('playerHand')
      # @checkScore('dealerHand')
    'click .stand-button': -> 
      @model.get('playerHand').stand()

  initialize: ->
    # @checkScore('playerHand')
    # @checkScore('dealerHand')
    @render()
    @flipppedOnce = false;

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  checkScore: (string) ->
    if @model.get('playerHand').scores()[1] > 21 then alert "u got rekt"
    document.location.reload(true);



