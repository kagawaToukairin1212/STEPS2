import { Controller } from "@hotwired/stimulus";
import Chart from "chart.js/auto";

// Stimulus Controller 定義
export default class extends Controller {
  connect() {
    console.log("📊 Bar Chart Controller Loaded!");

    // `canvas` 要素の `context` を取得
    const ctx = this.element.getContext("2d");

    // HTMLの `data-*` 属性からデータを取得
    const scores = JSON.parse(this.element.dataset.barChartScores); // スコアデータ
    const labels = JSON.parse(this.element.dataset.barChartLabels); // ラベル
    const colors = JSON.parse(this.element.dataset.barChartColors); // 色

    // Chart.js で棒グラフを描画
    new Chart(ctx, {
      type: "line",  // 棒グラフにするなら "bar"
      data: {
        labels: labels,
        datasets: scores.map((score, index) => ({
          label: `${score.date} の結果`,
          data: score.values,
          borderColor: colors[index % colors.length],
          backgroundColor: colors[index % colors.length].replace("0.5", "0.2"), // 透明度を変更
          borderWidth: 2
        }))
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
            suggestedMax: 10,
            ticks: {
              stepSize: 1
            }
          }
        }
      }
    });
  }
}