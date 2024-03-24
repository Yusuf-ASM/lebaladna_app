import { Router } from "express";
import * as backend from "../backend/adminBackend";
import * as db from "../helper/db";

export const admin = Router();

//okie
admin.post("/register/user", async (req, res) => {
  await backend.registerUserBackend(req, res);
});

//okie
admin.post("/register/ingredient", async (req, res) => {
  await backend.registerIngredientBackend(req, res);
});

//okie
admin.post("/register/meal", async (req, res) => {
  await backend.registerMealBackend(req, res);
});

//okie
admin.post("/register/campaign", async (req, res) => {
  await backend.registerCampaignBackend(req, res);
});

//okie
admin.get("/campaigns", async (req, res) => {
  await backend.getCampaignsBackend(req, res);
});

//okie
admin.get("/campaign/:campaignId", async (req, res) => {
  await backend.getCampaignBackend(req, res);
});

// TODO to be removed from here
admin.get("/ingredients", async (req, res) => {
  res.send(await db.getIngredients());
});

admin.get("/meals", async (req, res) => {
  res.send(await db.getMeals());
});

admin.get("/users", async (req, res) => {
  res.send(await db.getUsers());
});
