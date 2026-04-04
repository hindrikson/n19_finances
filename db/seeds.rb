# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Room.create(name: "room_1", due: 859.12, paid: 859.12, description: "")
Room.create(name: "room_2", due: 626.62, paid: 626.62, description: "")
Room.create(name: "room_3", due: 437.81, paid: 437.81, description: "")
Room.create(name: "room_4", due: 522.67, paid: 522.67, description: "")
Room.create(name: "room_5", due: 554.01, paid: 554.01, description: "")
Room.create(name: "room_6", due: 473.41, paid: 473.41, description: "")
Room.create(name: "room_7", due: 354.14, paid: 354.14, description: "")
Room.create(name: "room_8", due: 491.32, paid: 491.32, description: "")

# Create flatmates
Flatmate.create(name: "Jonathan", room_id: 1)
Flatmate.create(name: "Maren", room_id: 1)

Flatmate.create(name: "Ruda", room_id: 2)
Flatmate.create(name: "Arce", room_id: 3)
Flatmate.create(name: "Kimberly", room_id: 4)
Flatmate.create(name: "Tanja", room_id: 5)
Flatmate.create(name: "Viola", room_id: 6)
Flatmate.create(name: "Lisa", room_id: 7)
Flatmate.create(name: "Ronny", room_id: 8)

