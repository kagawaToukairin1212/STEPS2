import { Controller } from "@hotwired/stimulus";
import { Chart } from "chart.js";

export default class extends Controller {
  connect() {
    const ctx = this.element.getContext("2d");

    // HTMLのdata属性からデータを取得
    const scores = JSON.parse(this.element.dataset.radarChartScores);
    const labels = JSON.parse(this.element.dataset.radarChartLabels);

    // カラーパターン（赤→橙→黄→緑→青→藍→紫）
    const colors = ["red", "orange", "yellow", "green", "blue", "indigo", "purple"];

    // 各日付ごとのスコアデータを作成
    const datasets = scores.map((score, index) => ({
      label: score.date, // グラフの凡例（例：2024/04/04）
      data: score.values, // スコア
      borderColor: colors[index % colors.length], // 色を適用（ループ）
      backgroundColor: colors[index % colors.length] + "40", // 透明度
      borderWidth: 2
    }));

    // Chart.js でレーダーグラフを描画
    new Chart(ctx, {
      type: "radar",
      data: {
        labels: labels, // ラベル（評価項目）
        datasets: datasets // スコアデータ
      },
      options: {
        scales: {
          r: {
            beginAtZero: true, // 0 から開始
            min: 0,
            max: 10,
            ticks: { stepSize: 1 } // 目盛りを 1.0 ごとに
          }
        }
      }
    });
  }
}