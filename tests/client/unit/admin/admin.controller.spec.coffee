describe 'Admin controller', ->
  adminCtrl = {}

  beforeEach module('admin')

  beforeEach ->
    adminCtrl = new TestElement().createCtrl('adminCtrl')


  it 'should initialize', ->
    expect(adminCtrl).toBeDefined()
