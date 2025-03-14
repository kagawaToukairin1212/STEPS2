// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import RadarChartController from "./radar_chart_controller"
application.register("radar-chart", RadarChartController)

import RadarGraphController from "./radar_graph_controller"
application.register("radar-graph", RadarGraphController)

import BarChartController from "./bar_chart_controller";
application.register("bar-chart", BarChartController);