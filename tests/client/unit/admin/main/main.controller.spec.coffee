describe 'mainA controller', ->
  mainACtrl = {}

  beforeEach module('admin')

  beforeEach ->
    mainACtrl = new TestElement().createCtrl('mainACtrl')


  it 'should initialize', ->
    expect(mainACtrl).toBeDefined()
