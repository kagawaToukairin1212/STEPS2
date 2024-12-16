import { Controller } from "@hotwired/stimulus";
import Chart from "chart.js/auto";

export default class extends Controller {
  static targets = ["chart"];

  connect() {
    // データを取得する
    const sheets = JSON.parse(this.element.dataset.sheets);

    sheets.forEach((sheet, index) => {
      const ctx = document.getElementById(`radarChart-${index}`).getContext("2d");
      new Chart(ctx, {
        type: "radar",
        data: {
          labels: sheet.labels, // ラベル (例: リズム能力, バランス能力)
          datasets: [
            {
              label: "最新結果",
              data: sheet.latestResults, // 最新のデータ
              backgroundColor: "rgba(255, 99, 132, 0.2)",
              borderColor: "rgba(255, 99, 132, 1)",
              borderWidth: 1,
            },
            {
              label: "過去結果",
              data: sheet.previousResults, // 過去のデータ
              backgroundColor: "rgba(54, 162, 235, 0.2)",
              borderColor: "rgba(54, 162, 235, 1)",
              borderWidth: 1,
            },
          ],
        },
        options: {
          responsive: true,
          scales: {
            r: {
              beginAtZero: true,
              max: 10,
            },
          },
        },
      });
    });
  }
}
