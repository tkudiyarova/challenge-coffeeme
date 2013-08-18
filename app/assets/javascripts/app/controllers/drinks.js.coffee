$ = Spine.$
Drink = App.Drink

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Drink.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('drinks/new')

  back: ->
    @navigate '/drinks'

  submit: (e) ->
    e.preventDefault()
    drink = Drink.fromForm(e.target).save()
    @navigate '/drinks', drink.id if drink

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Drink.find(id)
    @render()
    
  render: ->
    @html @view('drinks/edit')(@item)

  back: ->
    @navigate '/drinks'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/drinks'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Drink.find(id)
    @render()

  render: ->
    @html @view('drinks/show')(@item)

  edit: ->
    @navigate '/drinks', @item.id, 'edit'

  back: ->
    @navigate '/drinks'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Drink.bind 'refresh change', @render
    Drink.fetch()
    
  render: =>
    drinks = Drink.all()
    @html @view('drinks/index')(drinks: drinks)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/drinks', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/drinks', item.id
    
  new: ->
    @navigate '/drinks/new'
    
class App.Drinks extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/drinks/new':      'new'
    '/drinks/:id/edit': 'edit'
    '/drinks/:id':      'show'
    '/drinks':          'index'
    
  default: 'index'
  className: 'stack drinks'