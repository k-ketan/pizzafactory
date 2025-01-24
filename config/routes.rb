# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :pizzas
  resources :orders
  resources :menu, only: [:index]
  resources :toppings
  resources :crusts
  post 'inventory/restock', to: 'inventory#restock'
end
