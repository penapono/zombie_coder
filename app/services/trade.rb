class Trade
  def initialize(from_survivor, to_survivor, items_from, items_to)
    @from_survivor = from_survivor
    @to_survivor = to_survivor
    @items_from = load_items(from_survivor, items_from)
    @items_to = load_items(to_survivor, items_to)
  end

  def call
    ActiveRecord::Base.transaction do
      return if any_infected? || !balanced_trade?
      perform_trade
    end
  end

  private

  def perform_trade
    @items_from.update_all(survivor_id: @to_survivor.id)
    @items_to.update_all(survivor_id: @from_survivor.id)
  end

  def any_infected?
    @from_survivor.infected? || @to_survivor.infected?
  end

  def load_items(survivor, items)
    survivor.items.where(name: items)
  end

  def balanced_trade?
    sum_from = 0
    @items_from.each do |item|
      sum_from += item.ammount * item.points
    end

    sum_to = 0
    @items_to.each do |item|
      sum_to += item.ammount * item.points
    end

    sum_to == sum_from
  end
end
