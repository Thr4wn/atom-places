AtomPlaces = require '../lib/atom-places'
CSON = require 'season'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomPlaces", ->
  [workspaceElement, activationPromise, nodes, trees, markers, current_marker] = []

  ###
  ##
  ##  Setting up and testing properties and test variables
  ##
  ###
  get_props: ->
    ## First test reading cson file
    file_location = atom.config.get('bookmark-tree.node_file_location')
    expect(file_location)
    props_system = CSON.readFile(file_location)
    expect(props_system)
    ## then test the function doing that.
    AtomPlaces.initialize_from_props()

  setup_file_env ->
    open_file_set_as_current("a\nb\nc\nd\nefg\nh")

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-places')
    get_props()
    setup_file_env() #TODO: only for the tests that need it?

  describe "on initialization of package", ->
    it "should have written bookmark-tree.cson properties file", ->
      expect(false) #TODO: activationPromise

  describe "All the time", ->
    it "should be able to access system properties", ->
      expect(nodes == {})
      expect(trees == {})

    it "should be able to access project properties", ->
      expect(markers == {})
      expect(current_marker == "")

  ###
  ##
  ##  Testing commands
  ##
  ###
  describe "when the atom-places:add-list event is triggered", ->
    it "Should make a new tree", ->
      atom.commands.dispatch workspaceElement, 'atom-places:add-list' #TODO: dispatch command, or run underlying function?
      #TODO: how name the tree?
      trees.size == 1
      nodes.size == 1

  describe "when the atom-places:add-bookmark event is triggered", ->
    it "Should make a new child bookmark", ->
      curser_at("c")
      trees.xyz = Tree.new(...)
      atom.commands.dispatch workspaceElement, 'atom-places:add-bookmark'
      nodes.size == 2

  # describe "when the atom-places:toggle event is triggered", ->
  #   it "hides and shows the modal panel", ->
  #     # Before the activation event the view is not on the DOM, and no panel
  #     # has been created
  #     expect(workspaceElement.querySelector('.atom-places')).not.toExist()
  #
  #     # This is an activation event, triggering it will cause the package to be
  #     # activated.
  #     atom.commands.dispatch workspaceElement, 'atom-places:toggle'
  #
  #     waitsForPromise ->
  #       activationPromise
  #
  #     runs ->
  #       expect(workspaceElement.querySelector('.atom-places')).toExist()
  #
  #       atomPlacesElement = workspaceElement.querySelector('.atom-places')
  #       expect(atomPlacesElement).toExist()
  #
  #       atomPlacesPanel = atom.workspace.panelForItem(atomPlacesElement)
  #       expect(atomPlacesPanel.isVisible()).toBe true
  #       atom.commands.dispatch workspaceElement, 'atom-places:toggle'
  #       expect(atomPlacesPanel.isVisible()).toBe false
  #
  #   it "hides and shows the view", ->
  #     # This test shows you an integration test testing at the view level.
  #
  #     # Attaching the workspaceElement to the DOM is required to allow the
  #     # `toBeVisible()` matchers to work. Anything testing visibility or focus
  #     # requires that the workspaceElement is on the DOM. Tests that attach the
  #     # workspaceElement to the DOM are generally slower than those off DOM.
  #     jasmine.attachToDOM(workspaceElement)
  #
  #     expect(workspaceElement.querySelector('.atom-places')).not.toExist()
  #
  #     # This is an activation event, triggering it causes the package to be
  #     # activated.
  #     atom.commands.dispatch workspaceElement, 'atom-places:toggle'
  #
  #     waitsForPromise ->
  #       activationPromise
  #
  #     runs ->
  #       # Now we can test for view visibility
  #       atomPlacesElement = workspaceElement.querySelector('.atom-places')
  #       expect(atomPlacesElement).toBeVisible()
  #       atom.commands.dispatch workspaceElement, 'atom-places:toggle'
  #       expect(atomPlacesElement).not.toBeVisible()
