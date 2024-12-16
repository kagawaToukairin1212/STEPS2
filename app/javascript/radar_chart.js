import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

document.addEventListener("DOMContentLoaded", () => {
  const radarCharts = document.querySelectorAll('[data-controller="radar-chart"]');

  radarCharts.forEach((chartElement, index) => {
    const sheetsData = JSON.parse(chartElement.dataset.sheets);

    sheetsData.forEach((sheet, idx) => {
      const ctx = document.getElementById(`radarChart-${idx}`).getContext("2d");

      new Chart(ctx, {
        type: "radar",
        data: {
          labels: sheet.labels,
          datasets: [
            {
              label: "最新結果",
              data: sheet.latestResults,
              backgroundColor: "rgba(54, 162, 235, 0.2)",
              borderColor: "rgb(54, 162, 235)",
              borderWidth: 2,
            },
            {
              label: "過去結果",
              data: sheet.previousResults,
              backgroundColor: "rgba(255, 99, 132, 0.2)",
              borderColor: "rgb(255, 99, 132)",
              borderWidth: 2,
            },
          ],
        },
        options: {
          responsive: true,
          scales: {
            r: {
              beginAtZero: true,
            },
          },
        },
      });
    });
  });
});
