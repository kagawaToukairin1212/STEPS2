# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
EvaluationDepartment.create([
  { name: "リズム能力", default: true },
  { name: "バランス能力", default: true },
  { name: "変換能力", default: true },
  { name: "反応能力", default: true },
  { name: "連結能力", default: true },
  { name: "定位能力", default: true },
  { name: "識別能力", default: true },
  # 追加の項目は`default: false`に設定
  # { name: "新しい項目1", default: false },
  # { name: "新しい項目2", default: false }
])
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
