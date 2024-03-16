import { Request, Response } from "express";
import * as utility from "../helper/utility";
import * as db from "../helper/db";
import Joi from "joi";
import { Meal } from "../helper/schema";

export async function registerUserBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    password: Joi.string().trim().required(),
    name: Joi.string().trim().required(),
  });

  let validationResult = schema.validate(body);

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
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function registerIngredientBackend(req: Request, res: Response) {
  const body = req.body;

  const schema = Joi.object({
    name: Joi.string().trim().required(),
    measureUnit: Joi.string().trim().required(),
  });

  let validationResult = schema.validate(body);

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
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function registerMealBackend(req: Request, res: Response) {
  const body = req.body;
  console.log(body);

  if (Object.keys(body).length == 0) {
    res.status(400).send({ error: "Empty Body" });
    return;
  }


  let validationResult = Meal.validate(body);
  // TODO need to check ingredient data

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
    res.status(400).send({ error: validationResult.error.message });
  }
}

export async function registerCampaignBackend(req: Request, res: Response) {
  const body = req.body;

  if (Object.keys(body).length == 0) {
    res.status(400).send({ error: "Empty Body" });
    return;
  }

  let checkingResult = utility.checkParameter({
    body: body,
    strings: ["name"],
    objectIds: ["kitchenLeader"],
  });

  const schema = Joi.object({
    name: Joi.string().trim().required(),
  });

  let validationResult = schema.validate(body);
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
