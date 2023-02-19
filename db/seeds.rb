# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(user_name: 'Иванов Иван Иванович', 
            login: 'ivanov',
            password: '12345678',
            password_confirmation: '12345678',
            position: 'физическое лицо',
            income: 1000000)
Realty.create(user_id: User.find_by(login: 'ivanov').id,
              address: 'Москва, Пресненский проспект 28/2, 17',
              square: 150,
              cost: 25000000)
Vehicle.create(user_id: User.find_by(login: 'ivanov').id,
               license_plate: 'а777аа777',
               model: 'Lamborghini Aventador',
               power: 780)