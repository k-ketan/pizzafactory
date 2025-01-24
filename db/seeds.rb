# frozen_string_literal: true

# Pizzas
[{ name: 'Deluxe Veggie', price: 150, category: 'vegetarian', size: 'regular' },
 { name: 'Non-Veg Supreme', price: 190, category: 'non_vegetarian', size: 'regular' }].each do |pizza|
  Pizza.find_or_initialize_by(name: pizza[:name], size: pizza[:size]).update(pizza)
end

# Toppings
[{ name: 'Black Olive', price: 20, category: 'veg' },
 { name: 'Chicken Tikka', price: 35, category: 'non_veg' }].each do |topping|
  Topping.find_or_initialize_by(name: topping[:name]).update(topping)
end

# Crusts
[{ name: 'New hand tossed' }, { name: 'Wheat thin crust' }].each do |crust|
  Crust.find_or_initialize_by(name: crust[:name]).save
end

# Sides
[{ name: 'Cold drink', price: 55 }, { name: 'Mousse cake', price: 90 }].each do |side|
  Side.find_or_initialize_by(name: side[:name]).update(side)
end

# Inventory
[{ item_name: 'Black Olive', quantity: 50 },
 { item_name: 'Chicken Tikka', quantity: 30 }].each do |inventory|
  Inventory.find_or_initialize_by(item_name: inventory[:item_name]).update(inventory)
end

# Users
User.find_or_initialize_by(email: 'vendor@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = 'vendor'
  user.save
end

User.find_or_initialize_by(email: 'customer@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = 'customer'
  user.save
end
