import { Request, Response } from "express";
import * as utility from "../helper/utility";
import * as db from "../helper/db";
import Joi from "joi";
import { Meal } from "../helper/schema";

//okie
export async function registerUserBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    password: utility.jString.required(),
    name: utility.jString.required(),
  });

  let validationResult = schema.validate(body);
  console.log("registerUserBackend:");

  if (validationResult.error === undefined) {
    let result = await db.registerUser(body);
    console.log(result);
    if (!Array.isArray(result) && result) {
      res.send(result);
    } else if (!result) {
      res.status(500).send({ error: "Could not register the user." });
    } else {
      res.status(result[0] as number).send({ error: result[1] });
    }
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

//okie
export async function registerIngredientBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    name: utility.jString.required(),
    measureUnit: utility.jString.required(),
  });

  let validationResult = schema.validate(body);
  console.log("registerIngredientBackend:");

  if (validationResult.error === undefined) {
    let result = await db.registerIngredient(body);
    console.log(result);
    if (!Array.isArray(result) && result) {
      res.send(result);
    } else if (!result) {
      res.status(500).send({ error: "Could not register the Ingredient." });
    } else {
      res.status(result[0] as number).send({ error: result[1] });
    }
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

//okie
export async function registerMealBackend(req: Request, res: Response) {
  const body = req.body;

  let validationResult = Meal.validate(body);
  console.log("registerMealBackend:");

  if (validationResult.error === undefined) {
    let result = await db.registerMeal(body);
    console.log(result);
    if (!Array.isArray(result) && result) {
      res.send(result);
    } else if (!result) {
      res.status(500).send({ error: "Could not register the Meal." });
    } else {
      res.status(result[0] as number).send({ error: result[1] });
    }
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function registerCampaignBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    name: utility.jString.required(),
    kitchenLeader: utility.jObjectId.required(),
    stationLeaders: Joi.array().required().items(utility.jObjectId),
    meals: Joi.object().pattern(utility.jString, Meal),
  });

  let validationResult = schema.validate(body);
  console.log("registerCampaignBackend:");

  if (validationResult.error === undefined) {
    let result = await db.registerCampaign(body);
    console.log(result);
    if (!Array.isArray(result) && result) {
      res.send(result);
    } else if (!result) {
      res.status(500).send({ error: "Could not register the Campaign." });
    } else {
      res.status(result[0] as number).send({ error: result[1] });
    }
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function getCampaignsBackend(req: Request, res: Response) {
  let result = await db.getCampaigns();
  res.send(result);
  console.log("getCampaignsBackend:");
  console.log(result);
}

export async function getCampaignBackend(req: Request, res: Response) {
  const params = req.params;

  const schema = Joi.object({
    campaignId: utility.jObjectId.required(),
  });

  let validationResult = schema.validate(params);
  console.log("getCampaignBackend:");

  if (validationResult.error === undefined) {
    let result = await db.getCampaign(params.campaignId);
    res.send(result); 
    console.log(result);
  } else {
    console.log(JSON.stringify(validationResult.error));
    res.status(400).send({ error: validationResult.error.message });
  }
}

//TODO continue
export async function getCampaignsReportBackend(req: Request, res: Response) {
  let result = await db.getCampaigns();
  res.send(result);
  console.log("getCampaignsBackend:");
  console.log(result);
}
