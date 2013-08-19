$ = Spine.$
Order = App.Order

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Order.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form':            'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('orders/new')

  back: ->
    @navigate '/orders'

  submit: (e) ->
    e.preventDefault()
    order = Order.fromForm(e.target).save()
    @navigate '/orders', order.id if order

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Order.find(id)
    @render()
    
  render: ->
    @html @view('orders/edit')(@item)

  back: ->
    @navigate '/orders'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/orders'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]':     'edit'
    'click [data-type=destroy]':  'destroy'
    'click [data-type=back]':     'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Order.find(id)
    @render()

  render: ->
    @html @view('orders/show')(@item)

  edit: ->
    @navigate '/orders', @item.id, 'edit'

  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')

  back: ->
    @navigate '/orders'

class Index extends Spine.Controller
  events:
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'
    'click .clickable tbody tr': 'my_func'

  constructor: ->
    super
    Order.bind 'refresh change', @render
    Order.fetch()
    
  render: =>
    orders = Order.all()
    @html @view('orders/index')(orders: orders)
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/orders', item.id
    
  new: ->
    @navigate '/orders/new'

  my_func: (e) ->
    $(e.target).addClass('selected')
    alert "hello: #{e}, e.targer: #{$(e.target)}, this: #{this}"
    
class App.Orders extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/orders/new':      'new'
    '/orders/:id/edit': 'edit'
    '/orders/:id':      'show'
    '/orders':          'index'
    
  default: 'index'
  className: 'stack orders'