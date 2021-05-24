# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
               { name: 'Sviehaper',
                 email: 'test@test.com',
                 password: '12345678',
                 password_confirmation: '12345678',
                 is_admin: 1 },
               { name: 'Petro Ivanow',
                 email: 'admin@gmail.com',
                 password: '123456qr',
                 password_confirmation: '123456qr',
                 is_admin: 1 }
             ])
