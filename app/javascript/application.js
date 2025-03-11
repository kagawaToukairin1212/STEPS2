// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "./controllers";  // ✅ これだけで Stimulus のすべてのコントローラーが自動読み込みされる
import * as bootstrap from "bootstrap";


// Chart.js を Importmap 経由で利用する
import { Chart, registerables } from "chart.js";
Chart.register(...registerables); // Chart.js の全機能を有効化


