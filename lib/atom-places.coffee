AtomPlacesView = require './atom-places-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomPlaces =
  atomPlacesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomPlacesView = new AtomPlacesView(state.atomPlacesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomPlacesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-places:add-bookmark': => @add_bookmark()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomPlacesView.destroy()

  serialize: ->
    atomPlacesViewState: @atomPlacesView.serialize()

  add_bookmark: ->
    console.log 'AtomPlaces: add_bookmark'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
