# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
#
Company.create!(
  [
    {  name: 'Dog Walking Inc.',
       url: 'http://dogwalkinginc.ca'
    }
  ]
)

User.create!(
  [
    {
      email: 'andrew.markle@gmail.com',
      password: 'password',
      company: Company.last
    }
  ]
)

Plan.create!(
  [
    {
      company: Company.last,
      name: '5 days a week',
      interval: 10,
      monday: true,
      tuesday: true,
      wednesday: true,
      thursday: true,
      friday: true,
      price_per_walk: 1900,
      total_price: 19_000
    },
    {
      company: Company.last,
      name: '3 days a week',
      interval: 6,
      monday: true,
      tuesday: false,
      wednesday: true,
      thursday: false,
      friday: true,
      price_per_walk: 2000,
      total_price: 12_000
    }
  ]
)
