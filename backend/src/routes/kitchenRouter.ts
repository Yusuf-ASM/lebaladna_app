import { Router } from "express";
import * as backend from "../backend/kitchenBackend";

export const kitchen = Router();

kitchen.post("/add/ingredient", async (req, res) => {
  await backend.addIngredientBackend(req, res);
});
kitchen.post("/get_kitchen_progress", async (req, res) => {
  await backend.getKitchenProgressBackend(req, res);
});
