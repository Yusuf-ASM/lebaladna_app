import { Router } from "express";
import * as backend from "../backend/kitchenBackend";

export const kitchen = Router();

kitchen.post("/add/ingredient", async (req, res) => {
  await backend.addIngredientBackend(req, res);
});
kitchen.get("/kitchen_progress/:campaignId", async (req, res) => {
  await backend.getKitchenProgressBackend(req, res);
});
