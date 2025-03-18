# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
[
  { name: "リズム能力", default: true },
  { name: "バランス能力", default: true },
  { name: "変換能力", default: true },
  { name: "反応能力", default: true },
  { name: "連結能力", default: true },
  { name: "定位能力", default: true },
  { name: "識別能力", default: true }
].each do |attributes|
  EvaluationDepartment.find_or_create_by!(name: attributes[:name]) do |department|
    department.default = attributes[:default]
  end
end

#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
