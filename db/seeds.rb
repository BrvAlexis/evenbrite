# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Créer des utilisateurs (admins) distincts pour chaque événement
admin_user1 = User.create!(
  email: 'admin1@example.com',
  password: 'password'
)

admin_user2 = User.create!(
  email: 'admin2@example.com',
  password: 'password'
)


event1 = Event.create!(
  start_date: DateTime.new(2024, 3, 15, 18, 0, 0),
  duration: 120,
  title: 'Éclats Étoilés: Une Soirée Magique',
  description: "Rejoignez-nous pour une soirée inoubliable sous les étoiles ! Notre événement exclusif propose une ambiance envoûtante, avec des performances artistiques époustouflantes, une cuisine exquise et une atmosphère festive. Plongez dans l'art et la culture tout en profitant de conversations inspirantes. Des souvenirs mémorables vous attendent à chaque coin. Ne manquez pas l'occasion de vivre cette expérience unique",

  price: 10,
  location: 'Centre-ville chic',
  admin: admin_user1,
  user: admin_user1 # Associer l'événement à l'utilisateur (admin)
)

event2 = Event.create!(
  start_date: DateTime.new(2024, 4, 10, 14, 30, 0),
  duration: 90,
  title: 'Voyage Artistique: Entre Tradition et Modernité',
  description: "Exploration de l'art contemporain à travers une collection exclusive. Plongez dans l'univers créatif des artistes émergents et découvrez des œuvres uniques qui suscitent la réflexion. Une expérience immersive qui transcende les frontières de l'expression artistique, créant un dialogue entre le spectateur et l'art contemporain. Laissez-vous inspirer par la diversité des perspectives et explorez la richesse infinie de la créativité moderne.",
  price: 15,
  location: 'Vue panoramique',
  admin: admin_user2,
  user: admin_user2
)


