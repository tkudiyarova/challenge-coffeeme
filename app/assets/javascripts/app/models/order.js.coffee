class App.Order extends Spine.Model
  @configure 'Order', 'name', 'comment', 'user_id', 'drink_id'
  @extend Spine.Model.Ajax