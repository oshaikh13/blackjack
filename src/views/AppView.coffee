class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()

      @checkScore()
      @dealerDecision()
      
    'click .stand-button': -> 
      @model.get('playerHand').stand()

      @flipHoleCard()
      @checkScore()
      @dealerDecision()

  initialize: ->
    @render()
    @flipppedOnce = false;

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  checkScore: ->

    @model.get('deck');

    pHand = @optimalScore(@model.get('playerHand').scores())
    dHand = @optimalScore(@model.get('dealerHand').scores())

    if pHand > 21 or dHand > pHand and dHand <= 21 and dHand >= 17
      @startNewGame(false)

    if dHand > 21 or dHand < pHand and pHand <= 21 and pHand >= 17
      @startNewGame(true)


  optimalScore: (arr) ->
    optimalScore = arr[0];
    if arr[1] <= 21
      optimalScore = arr[1];
    optimalScore

  dealerDecision: ->
    while @optimalScore(@model.get('dealerHand').scores()) <= 17
      @model.get('dealerHand').hit();

  flipHoleCard: ->
    if !@flipppedOnce
      @model.get('dealerHand').first().flip()
      @flipppedOnce = true

  startNewGame: (wonGame)->
    if !wonGame
      alert "u got rekt. new game starts?"
    else 
      alert "bruh u won niceeeeeeee"

    @$('.player-hand-container div').remove();
    @$('.dealer-hand-container div').remove();

    @createNewHands();

    @render();

    #document.location.reload(true);

  createNewHands: ->

    @model.set 'playerHand', @model.get('deck').dealPlayer()

    @model.set 'dealerHand', @model.get('deck').dealDealer()


    console.log @model.get('deck')





















