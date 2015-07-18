assert = chai.assert

describe 'deck', ->
  appModel = null
  game = null
  appView = null

  beforeEach ->
    appModel = new App()
    game = appModel.get('game')
    console.log game;
    appView = new AppView(model: game)

  describe "App View", ->
    it "should pick an optimal score", ->
      debugger;
      appView.optimalScore([17,27]).to.equal(17) 
      appView.optimalScore([7,17]).to.equal(17)
