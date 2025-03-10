import { Controller } from "@hotwired/stimulus";
import { Chart } from "chart.js/auto";

export default class extends Controller {
  connect() {

    console.log("✅ Stimulus RadarChartController is connected!");
    const ctx = this.element.getContext("2d");
    
    const scores = JSON.parse(this.element.dataset.radarGraphScores);
    const labels = JSON.parse(this.element.dataset.radarGraphLabels);

    if (!scores.length || !labels.length) {
      console.warn("⚠️ グラフデータが空です。");
      return;
    }

    console.log("Radar Chart - Received Scores: ", scores);
    console.log("Radar Chart - Received Labels: ", labels);

    const colors = [
      "rgba(255, 99, 132, 0.5)",  // 赤
      "rgba(255, 159, 64, 0.5)",  // オレンジ
      "rgba(255, 205, 86, 0.5)",  // 黄
      "rgba(75, 192, 192, 0.5)",  // 緑
      "rgba(54, 162, 235, 0.5)",  // 青
      "rgba(153, 102, 255, 0.5)", // 紫
      "rgba(201, 203, 207, 0.5)"  // グレー
    ];

    const datasets = scores.map((score, index) => ({
      label: score.date,
      data: score.values,
      borderColor: colors[index % colors.length],
      backgroundColor: colors[index % colors.length] + "40",
      borderWidth: 2
    }));

    new Chart(ctx, {
      type: "radar",
      data: {
        labels: labels,
        datasets: datasets
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          r: {
            beginAtZero: true,
            min: 0,
            max: 10,
            ticks: { stepSize: 1 }
          }
        }
      }
    });
  }
}
