assert = chai.assert

describe 'deck', ->
  appModel = null
  game = null
  appView = null

  beforeEach ->
    appModel = new App()
    game = appModel.get('game')
    appView = new AppView({model: game})

  describe "App View", ->
    it "should pick an optimal score", ->
      assert.strictEqual appView.optimalScore([17,27]), 17
      assert.strictEqual appView.optimalScore([7,17]), 17
    it "should check if a card is flipped", ->
      appView.flipHoleCard()
      assert.strictEqual appView.flippedOnce, true
    it "should deal four cards at the beginning", ->
      assert.strictEqual appView.checkDeckSize(), 48 
    it "should continuously deal cards until 17", ->
      appView.flipHoleCard()
      appView.dealAndDecide()

      console.log appView.optimalScore(appView.model.get('dealerHand').scores())
      debugger;

      assert.isAbove appView.optimalScore(appView.model.get('dealerHand').scores()), 16


