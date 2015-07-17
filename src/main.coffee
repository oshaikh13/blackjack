appModel = new App()
game = appModel.get('game');

new AppView(model: game).$el.appendTo 'body'
