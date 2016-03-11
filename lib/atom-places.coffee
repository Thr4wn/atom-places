AtomPlacesView = require './atom-places-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomPlaces =
  atomPlacesView: null
  modalPanel: null
  subscriptions: null
  [nodes, trees, markers, current_marker] = []

  activate: (state) ->
    @atomPlacesView = new AtomPlacesView(state.atomPlacesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomPlacesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-places:add-bookmark': => @add_bookmark()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-places:prev-bookmark': => @prev_bookmark()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-places:next-bookmark': => @next_bookmark()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomPlacesView.destroy()

  serialize: ->
    atomPlacesViewState: @atomPlacesView.serialize()

  initialize_from_props: ->
    ## read properties
    props_project = atom.project.props
    file_location = atom.config.get('bookmark-tree.node_file_location')
    props_system = CSON.readFile(file_location)
    ## assign variables
    nodes = props_system.bookmark_tree_nodes
    trees = props_system.bookmark_tree_trees
    markers = props_project.markers
    current_marker = props_project.current_marker

  get_lists

  ###
  ##  Commands
  ###
  add_bookmark: ->
    console.log 'AtomPlaces: add_bookmark'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  prev_bookmark: ->
    console.log 'AtomPlaces: add_bookmark'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  next_bookmark: ->
    console.log 'AtomPlaces: add_bookmark'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
