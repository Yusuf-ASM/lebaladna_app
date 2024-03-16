import { Request, Response } from "express";
import * as utility from "../helper/utility";
import * as db from "../helper/db";
import Joi from "joi";
import { Meal } from "../helper/schema";

//okie
export async function registerUserBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    password: Joi.string().trim().required(),
    name: Joi.string().trim().required(),
  });

  let validationResult = schema.validate(body);

  if (validationResult.error === undefined) {
    let result = await db.registerUser(body);
    console.log("registerUserBackend:");
    console.log(result);
    if (!Array.isArray(result) && result) {
      res.send(result);
    } else if (!result) {
      res.status(500).send({ error: "Could not register the user." });
    } else {
      res.status(result[0] as number).send({ error: result[1] });
    }
  } else {
    res.status(400).send({ error: validationResult.error.message });
  }
}

//okie
export async function registerIngredientBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    name: Joi.string().trim().required(),
    measureUnit: Joi.string().trim().required(),
  });

  let validationResult = schema.validate(body);

  if (validationResult.error === undefined) {
    let result = await db.registerIngredient(body);
    console.log("registerIngredientBackend:");
    console.log(result);
    if (!Array.isArray(result) && result) {
      res.send(result);
    } else if (!result) {
      res.status(500).send({ error: "Could not register the Ingredient." });
    } else {
      res.status(result[0] as number).send({ error: result[1] });
    }
  } else {
    res.status(400).send({ error: validationResult.error.message });
  }
}

//okie
export async function registerMealBackend(req: Request, res: Response) {
  const body = req.body;
  console.log(body);

  let validationResult = Meal.validate(body);

  if (validationResult.error === undefined) {
    let result = await db.registerMeal(body);
    console.log("registerMealBackend:");
    console.log(result);
    if (!Array.isArray(result) && result) {
      res.send(result);
    } else if (!result) {
      res.status(500).send({ error: "Could not register the Meal." });
    } else {
      res.status(result[0] as number).send({ error: result[1] });
    }
  } else {
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function registerCampaignBackend(req: Request, res: Response) {
  const body = req.body;
  // meals: {
  //   'roz-kofta': {
  //     _id: '65ef3a0236d45c9eb682eeab',
  //     name: 'roz-kofta',
  //     ingredients: [Array],
  //     target: 10,
  //     cooked: 0
  //   }
  const schema = Joi.object({
    name: utility.jString.required(),
    kitchenLeader: utility.jObjectId.required(),
    stationLeaders: Joi.array().required().items(utility.jObjectId),
    meals: Joi.object().pattern(utility.jString, Meal),
  });

  let validationResult = schema.validate(body);
  console.log(validationResult.error);

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
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function getCampaignsBackend(req: Request, res: Response) {
  let result = await db.getCampaigns();
  res.send(result);
  console.log("getCampaignsBackend:");
  console.log(result);
}

export async function getCampaignsReportBackend(req: Request, res: Response) {
  let result = await db.getCampaigns();
  res.send(result);
  console.log("getCampaignsBackend:");
  console.log(result);
}
