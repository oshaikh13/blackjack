class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      @checkDeckSize()
      @model.get('playerHand').hit()

      @checkScore()
      
    'click .stand-button': -> 
      @model.get('playerHand').stand()

      @flipHoleCard()
      @checkScore()
      @dealerDecision()

  initialize: ->
    @render()
    @flippedOnce = false;

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  checkScore: ->


    pHand = @optimalScore(@model.get('playerHand').scores())
    dHand = @optimalScore(@model.get('dealerHand').scores())

    if @flippedOnce 
      # Relative decisions for the player
      if pHand > 21
        @startNewGame(false)
      else if pHand >= 17 and dHand > 21
        @startNewGame(true)
      else if pHand >= 17 and dHand >= 17
        if pHand == dHand
          @startNewGame('what the tie')
        else if pHand > dHand 
          @startNewGame(true)
        else
          @startNewGame(false)
      # Relative decisions for the dealer
      else if dHand > 21
        @startNewGame(true)
      else if dHand >= 17
        @startNewGame(false)
    else 
      if pHand > 21
        @startNewGame(false)



    # if pHand > 21
    #   @startNewGame(false)

    # if pHand == 21
    #   @startNewGame(true)


    # if @flippedOnce
    #   if pHand > 21 or dHand > pHand and dHand <= 21 and dHand >= 17
    #     @startNewGame(false)
    #   else if dHand > 21 and pHand <= 21 
    #     @startNewGame(true)
      
    





  optimalScore: (arr) ->
    optimalScore = arr[0];
    if arr[1] <= 21
      optimalScore = arr[1];
    optimalScore

  dealAndDecide: ->
    if @flippedOnce
      while @optimalScore(@model.get('dealerHand').scores()) < 17
        @checkDeckSize()
        @model.get('dealerHand').hit();
      
  dealerDecision: ->
    @dealAndDecide()
    @checkScore()



  flipHoleCard: ->
    if !@flippedOnce
      @model.get('dealerHand').first().flip()
      @flippedOnce = true

  startNewGame: (wonGame)->



    if wonGame == "what the tie"
      alert 'TIE LOL SWEG GET SHREKT BLAZE IT' 


    else if !wonGame
      alert 'u lost m8. sux dusnt it' 
    else 
      alert 'BRUH WTNICEEEE u won' 


    @checkDeckSize();

    @$('.player-hand-container div').remove();
    @$('.dealer-hand-container div').remove();

    @createNewHands();

    @render();

    #document.location.reload(true);

  createNewHands: ->

    @model.set 'playerHand', @model.get('deck').dealPlayer()

    @model.set 'dealerHand', @model.get('deck').dealDealer()

    @flippedOnce = false
    console.log @model.get('deck')


  checkDeckSize: ->
    deckSize = @model.get('deck').length
    if deckSize <= 1 
      alert('OUTAA CARDS M9. We need a new D3CKXXX');
      document.location.reload(true);
    deckSize


















