// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "./controllers";
import * as bootstrap from "bootstrap";
import "chartkick/chart.js"; // Chart.jsの機能を使用
import Chart from "chart.js/auto";
import "./controllers/radar_chart_controller";
import "./radar_chart";
