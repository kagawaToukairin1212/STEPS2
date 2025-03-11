import { Controller } from "@hotwired/stimulus";
import Chart from "chart.js/auto";

// Stimulus コントローラーを作成
export default class extends Controller {
    connect() {
        console.log("🚀 Radar Graph Controller Loaded!");
        // HTML 要素 (canvas) を取得
        const ctx = this.element;

        // データを HTML の `data-*` 属性から取得
        const scores = JSON.parse(this.data.get("scores"));  // スコアデータ
        const labels = JSON.parse(this.data.get("labels"));  // 評価項目ラベル
        const colors = JSON.parse(this.data.get("colors"));  // カラーパレット

        // Chart.js を使ってレーダーグラフを描画
        new Chart(ctx, {
            type: 'radar',
            data: {
                labels: labels, // 評価項目をラベルとして設定
                datasets: scores.map((score, index) => ({
                    label: `${score.date} の分析`, // 日付ごとのデータセット名
                    backgroundColor: colors[index % colors.length], // 背景色
                    borderColor: colors[index % colors.length].replace("0.5", "1"), // 枠線の色
                    pointBackgroundColor: colors[index % colors.length].replace("0.5", "1"), // 結合点の色
                    pointBorderColor: "#fff", // 結合点の枠線
                    pointHoverBackgroundColor: "#fff", // ホバー時の結合点の色
                    pointHoverBorderColor: colors[index % colors.length].replace("0.5", "1"), // ホバー時の枠線
                    data: score.values // 各項目の評価データ
                }))
            },
            options: {
                responsive: true, // レスポンシブ対応
                maintainAspectRatio: false, // アスペクト比を固定しない
                scales: {
                    r: {
                        suggestedMin: 0, // 最小値 0
                        suggestedMax: 10, // 最大値 10
                        ticks: {
                            stepSize: 1 // 1 ずつ増減
                        }
                    }
                },
                plugins: {
                    legend: {
                        position: "top" // 凡例を上部に表示
                    }
                }
            }
        });
    }
}
