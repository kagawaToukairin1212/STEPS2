# Pin npm packages by running ./bin/importmap

pin "application", to: "application.js", preload: true # application.js を明示的に指定
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js"
pin "radar_chart", to: "radar_chart.js"
