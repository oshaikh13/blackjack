class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()

      @flipHoleCard()
      @checkScore()
      @dealerDecision()
      
    'click .stand-button': -> 
      @model.get('playerHand').stand()
      
      @flipHoleCard()
      @checkScore()
      @dealerDecision()

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

  checkScore: ->
    if @optimalScore(@model.get('playerHand').scores()) > 21
      alert "u got rekt. new game starts?"
      document.location.reload(true);

  optimalScore: (arr) ->
    optimalScore = arr[0];
    if arr[1] <= 21
      optimalScore = arr[1];
    optimalScore

  dealerDecision: ->
    if @optimalScore(@model.get('dealerHand').scores()) <= 17 then @model.get('dealerHand').hit();

  flipHoleCard: ->
    if !@flipppedOnce
      @model.get('dealerHand').first().flip()
      @flipppedOnce = true