import { Router } from "express";
import * as backend from "../backend/stationBackend";

export const station = Router();

station.post("/add/meal", async (req, res) => {
  await backend.addMealBackend(req, res);
});

station.post("/get_station_progress", async (req, res) => {
  await backend.getStationProgressBackend(req, res);
});
